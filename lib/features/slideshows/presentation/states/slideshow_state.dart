import 'package:flutter/material.dart';
import 'package:mosaico/shared/states/loadable_state.dart';
import 'package:mosaico_flutter_core/features/mosaico_slideshows/data/models/mosaico_slideshow_item.dart';
import 'package:mosaico_flutter_core/features/mosaico_slideshows/data/models/mosaico_slideshow.dart';
import 'package:mosaico_flutter_core/features/mosaico_slideshows/data/repositories/mosaico_slideshows_coap_repository.dart';
import 'package:mosaico_flutter_core/features/mosaico_slideshows/domain/repositories/mosaico_slideshows_repository.dart';

class SlideshowState extends LoadableState
{
  final MosaicoSlideshowsRepository _repository = MosaicoSlideshowsCoapRepository();
  final MosaicoSlideshow slideshow = MosaicoSlideshow(id: 0, name: '', items: []);

  SlideshowState();

  @override
  bool empty() {
    return true;
  }

  @override
  Future<void> loadResource() async {

  }
}
