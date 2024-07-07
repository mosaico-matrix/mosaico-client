import 'package:mosaico/shared/states/loadable_state.dart';
import 'package:mosaico_flutter_core/features/mosaico_slideshows/data/models/mosaico_slideshow.dart';
import 'package:mosaico_flutter_core/features/mosaico_slideshows/data/repositories/mosaico_slideshows_coap_repository.dart';
import 'package:mosaico_flutter_core/features/mosaico_slideshows/domain/repositories/mosaico_slideshows_repository.dart';

class SlideshowsState extends LoadableState
{

  /// Repositories
  final MosaicoSlideshowsRepository _mosaicoSlideshowsRepository = MosaicoSlideshowsCoapRepository();

  /// Slideshows
  List<MosaicoSlideshow> slideshows = [];

  @override
  Future<void> loadResource() async {
    loadingState.showLoading();
    slideshows = await _mosaicoSlideshowsRepository.getSlideshows();
    loadingState.hideLoading();
    notifyListeners();
  }


  @override
  bool empty() {
    return slideshows.isEmpty;
  }


}