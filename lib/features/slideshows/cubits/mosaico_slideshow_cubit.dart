import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mosaico_flutter_core/features/mosaico_slideshows/data/models/mosaico_slideshow.dart';
import 'package:mosaico_flutter_core/features/mosaico_slideshows/data/models/mosaico_slideshow_item.dart';

class MosaicoSlideshowCubit extends Cubit<MosaicoSlideshow> {

  MosaicoSlideshowCubit(super.slideshow);

  void updateSlideshowName(String newName) {
    state.name = newName;
  }

  void addSlideshowItem() {
    final newItems = List<MosaicoSlideshowItem>.from(state.items)
      ..add(MosaicoSlideshowItem(position: state.items.length));
    emit(state.copyWith(items: newItems));
  }

  void removeSlideshowItem(MosaicoSlideshowItem slideshowItem) {

  }


}
