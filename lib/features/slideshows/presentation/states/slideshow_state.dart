import 'package:flutter/cupertino.dart';
import 'package:mosaico/features/slideshows/presentation/states/slideshows_state.dart';
import 'package:mosaico/shared/states/loadable_state.dart';
import 'package:mosaico_flutter_core/core/utils/toaster.dart';
import 'package:mosaico_flutter_core/features/mosaico_slideshows/data/models/mosaico_slideshow_item.dart';
import 'package:mosaico_flutter_core/features/mosaico_slideshows/data/models/mosaico_slideshow.dart';
import 'package:mosaico_flutter_core/features/mosaico_slideshows/data/repositories/mosaico_slideshows_coap_repository.dart';
import 'package:mosaico_flutter_core/features/mosaico_widgets/data/models/mosaico_widget.dart';
import 'package:mosaico_flutter_core/features/mosaico_widgets/data/models/mosaico_widget_configuration.dart';
import 'package:mosaico_flutter_core/features/mosaico_widgets/data/repositories/mosaico_widget_configurations_coap_repository.dart';
import 'package:mosaico_flutter_core/features/mosaico_widgets/domain/repositories/mosaico_widget_configurations_repository.dart';
import 'package:mosaico_flutter_core/features/mosaico_slideshows/domain/repositories/mosaico_slideshows_repository.dart';
import 'package:provider/provider.dart';

class SlideshowState extends LoadableState {
  late MosaicoSlideshow _slideshow;
  late bool _newSlideshow;
  final MosaicoWidgetConfigurationsCoapRepository _widgetConfigurationsRepository =
      MosaicoWidgetConfigurationsCoapRepository();
  MosaicoSlideshowsRepository _slideshowsRepository =
      MosaicoSlideshowsCoapRepository();

  SlideshowState(MosaicoSlideshow? slideshow) {
    slideshow == null
        ? {_newSlideshow = true, _slideshow = MosaicoSlideshow()}
        : {_newSlideshow = false, _slideshow = slideshow};
  }

  @override
  Future<void> loadResource(BuildContext context) async {
    // Check if slideshow is in edit mode
    if (_newSlideshow) {
      return;
    }


    // // Get installed widgets state
    // final widgetsState = Provider.of<InstalledWidgetsState>(context, listen: false);
    // for (var item in _slideshow.items) {
    //   // Get widget
    //   final widget = widgetsState.getWidgetById(item.widgetId);
    //   if (widget == null) {
    //     continue;
    //   }
    //
    //   // Get widget configurations
    //   final configurations = await getWidgetConfigurations(widget.id);
    //   if (configurations.isEmpty) {
    //     continue;
    //   }
    //
    //   // Set configuration
    //   item.shouldSelectConfiguration = widget.metadata?.configurable == true;
    // }
    //
    // notifyListeners();
  }

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

  /// When selected a widget that not requires configuration, it should be selected automatically
  bool shouldSelectConfiguration(MosaicoSlideshowItem slideshowItem) {
    return slideshowItem.shouldSelectConfiguration;
  }

  /// Set a new widget for a slideshow item
  void updateItemWidget(
      MosaicoSlideshowItem slideshowItem, MosaicoWidget? widget) {
    if (widget == null) {
      return;
    }
    slideshowItem.widgetId = widget.id;
    slideshowItem.shouldSelectConfiguration =
        widget.metadata?.configurable == true;
    notifyListeners();
  }

  void updateItemConfig(MosaicoSlideshowItem slideshowItem,
      MosaicoWidgetConfiguration? configuration) {
    if (configuration == null) {
      return;
    }
    slideshowItem.configId = configuration.id;
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
  Future<void> saveSlideshow(BuildContext context) async {
    // Validate slideshow
    if (_validSlideshow() == false) {
      return;
    }

    // Install slideshow
    loadingState.showLoading();
    _slideshow =
        await _slideshowsRepository.createOrUpdateSlideshow(_slideshow);

    // Add slideshow to list in homepage
    if (_newSlideshow) {
      Provider.of<SlideshowsState>(context, listen: false)
          .addSlideshow(_slideshow);
      _newSlideshow = false; // Now it's an existing slideshow ;)
    }

    await loadResource(context);
    loadingState.hideLoading();
    notifyListeners();
  }

  /// Activate slideshow on the matrix
  Future<void> activateSlideshow(BuildContext context) async {
    // Save before activating
    await saveSlideshow(context);

    loadingState.showLoading();
    await _slideshowsRepository.setActiveSlideshow(_slideshow.id!);
    loadingState.hideLoading();
  }

  bool _validSlideshow() {
    if (_slideshow.name.isEmpty) {
      Toaster.error("Slideshow name cannot be empty");
      return false;
    }
    if (_slideshow.items.isEmpty || _slideshow.items.length < 2) {
      Toaster.error("Slideshow must have at least 2 items");
      return false;
    }

    for (var item in _slideshow.items) {
      if (item.widgetId == -1) {
        Toaster.error("All items must have a widget");
        return false;
      }
      if (item.configId == null && shouldSelectConfiguration(item)) {
        Toaster.error("You didn't select a configuration for a widget");
        return false;
      }

      if (item.secondsDuration < 1) {
        Toaster.error("Duration must be greater than 0");
        return false;
      }
    }

    return true;
  }

  @override
  bool empty() {
    return _slideshow.items.isEmpty;
  }
}
