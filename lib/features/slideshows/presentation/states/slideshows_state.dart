import 'package:flutter/src/widgets/framework.dart';
import 'package:mosaico/shared/states/loadable_state.dart';
import 'package:mosaico_flutter_core/common/widgets/dialogs/confirmation_dialog.dart';
import 'package:mosaico_flutter_core/features/mosaico_slideshows/data/models/mosaico_slideshow.dart';
import 'package:mosaico_flutter_core/features/mosaico_slideshows/data/repositories/mosaico_slideshows_coap_repository.dart';
import 'package:mosaico_flutter_core/features/mosaico_slideshows/domain/repositories/mosaico_slideshows_repository.dart';

class SlideshowsState extends LoadableState
{

  /// Repositories
  final MosaicoSlideshowsRepository _slideshowsRepository = MosaicoSlideshowsCoapRepository();

  /// Slideshows
  List<MosaicoSlideshow> slideshows = [];

  @override
  Future<void> loadResource() async {
    loadingState.showLoading();
    slideshows = await _slideshowsRepository.getSlideshows();
    loadingState.hideLoading();
    notifyListeners();
  }

  /// Add a new slideshow created from the new slideshow page
  void addSlideshow(MosaicoSlideshow slideshow)
  {
    slideshows.add(slideshow);
    notifyListeners();
  }
  
  Future<void> playSlideshow(BuildContext context, MosaicoSlideshow slideshow)  async
  {
    loadingState.showLoading();
    await _slideshowsRepository.setActiveSlideshow(slideshow.id!);
    loadingState.hideLoading();
  }

  Future<void> deleteSlideshow(BuildContext context, MosaicoSlideshow slideshow) async
  {
    // Show confirmation dialog
    final confirmed = await ConfirmationDialog.ask(
      context: context,
      title: "Delete slideshow",
      message: "Are you sure you want to delete slideshow '${slideshow.name}'?",
    );
    if (!confirmed) return;

    loadingState.showLoading();
    await _slideshowsRepository.deleteSlideshow(slideshow.id!);
    slideshows.remove(slideshow);
    loadingState.hideLoading();
    notifyListeners();
  }


  @override
  bool empty() {
    return slideshows.isEmpty;
  }


  @override
  /// This state should not be disposed
  void dispose() {
    return;
  }

}