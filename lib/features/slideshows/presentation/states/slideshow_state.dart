import 'package:mosaico/shared/states/loadable_state.dart';
import 'package:mosaico_flutter_core/features/mosaico_slideshows/data/models/mosaico_slideshow_item.dart';
import 'package:mosaico_flutter_core/features/mosaico_slideshows/data/models/mosaico_slideshow.dart';
import 'package:mosaico_flutter_core/features/mosaico_slideshows/data/repositories/mosaico_slideshows_coap_repository.dart';
import 'package:mosaico_flutter_core/features/mosaico_widgets/data/models/mosaico_widget.dart';
import 'package:mosaico_flutter_core/features/mosaico_widgets/data/models/mosaico_widget_configuration.dart';
import 'package:mosaico_flutter_core/features/mosaico_widgets/data/repositories/mosaico_widget_configurations_coap_repository.dart';
import 'package:mosaico_flutter_core/features/mosaico_widgets/domain/repositories/mosaico_widget_configurations_repository.dart';
import 'package:mosaico_flutter_core/features/mosaico_slideshows/domain/repositories/mosaico_slideshows_repository.dart';

class SlideshowState extends LoadableState {
  late MosaicoSlideshow _slideshow;
  late bool _newSlideshow;
  final MosaicoWidgetConfigurationsRepository _widgetConfigurationsRepository =
      MosaicoWidgetConfigurationsCoapRepository();
  MosaicoSlideshowsRepository _slideshowsRepository =
      MosaicoSlideshowsCoapRepository();

  SlideshowState(MosaicoSlideshow? slideshow) {
    slideshow == null
        ? {_newSlideshow = true, _slideshow = MosaicoSlideshow()}
        : {_newSlideshow = false, _slideshow = slideshow};
  }

  @override
  Future<void> loadResource() async {}

  /*
  * Slideshow name
  */
  String getSlideshowName() {
    return _slideshow.name;
  }

  void setSlideshowName(String name) {
    _slideshow.name = name;
  }

  /*
  * Slideshow items
  */

  /// Reorders the items in the slideshow based on position and returns the list of items
  List<MosaicoSlideshowItem> getItems() {
    _slideshow.items.sort((a, b) => a.position.compareTo(b.position));
    return _slideshow.items;
  }

  /// Add a new item to the slideshow
  void addSlideshowItem() {
    _slideshow.items
        .add(MosaicoSlideshowItem(position: _slideshow.items.length));
    notifyListeners();
  }

  /// Remove an item from the slideshow
  void removeSlideshowItem(MosaicoSlideshowItem slideshowItem) {
    _slideshow.items.remove(slideshowItem);
    notifyListeners();
  }

  /// Returns the number of items in the slideshow
  int getItemsCount() {
    return _slideshow.items.length;
  }

  /// Swaps the positions of two items in the slideshow
  void updateItemPosition(int oldIndex, int newIndex) {
    _slideshow.items[oldIndex].position = newIndex;
    _slideshow.items[newIndex].position = oldIndex;
    notifyListeners();
  }

  /// Updates the duration of an item in the slideshow
  void updateItemDuration(MosaicoSlideshowItem slideshowItem, String value) {
    slideshowItem.secondsDuration = int.parse(value);
  }

  /// Disabled when did not select a widget
  bool shouldSelectConfiguration(MosaicoSlideshowItem slideshowItem) {
    return true;
    // Check if widget needs configuration
    // var widget =
    //
    // return slideshowItem.widgetId != -1;
  }

  /// Set a new widget for a slideshow item
  void updateItemWidget(
      MosaicoSlideshowItem slideshowItem, MosaicoWidget? widget) {
    if (widget == null) {
      return;
    }
    slideshowItem.widgetId = widget.id;
    notifyListeners();
  }

  /// Get a list of all widget configurations for a widget
  Future<List<MosaicoWidgetConfiguration>> getConfigurations(
      MosaicoSlideshowItem slideshowItem) async {
    if (!shouldSelectConfiguration(slideshowItem)) return [];

    return await _widgetConfigurationsRepository.getWidgetConfigurations(
        widgetId: slideshowItem.widgetId);
  }

  /// Return a list of widget configurations
  Future<List<MosaicoWidgetConfiguration>> getWidgetConfigurations(
      int widgetId) async {
    final configurations = await _widgetConfigurationsRepository
        .getWidgetConfigurations(widgetId: widgetId);
    return configurations;
  }

  /// Create or update a slideshow
  Future<void> saveSlideshow() async {
    loadingState.showLoading();
    _slideshow =
        await _slideshowsRepository.createOrUpdateSlideshow(_slideshow);
    _newSlideshow = false; // Now it's an existing slideshow ;)
    loadingState.hideLoading();
    notifyListeners();
  }

  /// Activate slideshow on the matrix
  Future<void> activateSlideshow() async {

    // Save before activating
    await saveSlideshow();

    loadingState.showLoading();
    await _slideshowsRepository.setActiveSlideshow(_slideshow.id!);
    loadingState.hideLoading();
  }

  @override
  bool empty() {
    return _slideshow.items.isEmpty;
  }
}
