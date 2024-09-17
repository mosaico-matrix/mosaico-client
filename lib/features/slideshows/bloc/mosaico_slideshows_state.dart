import 'package:equatable/equatable.dart';
import 'package:mosaico_flutter_core/features/mosaico_slideshows/data/models/mosaico_slideshow.dart';

abstract class MosaicoSlideshowsState extends Equatable {}

class SlideshowsInitialState extends MosaicoSlideshowsState {
  @override
  List<Object> get props => [];
}

class SlideshowsLoadingState extends MosaicoSlideshowsState {
  @override
  List<Object> get props => [];
}

class SlideshowsLoadedState extends MosaicoSlideshowsState {
  final List<MosaicoSlideshow> slideshows;

  SlideshowsLoadedState({required this.slideshows});

  @override
  List<Object> get props => [slideshows];
}

class NoSlideshowsState extends MosaicoSlideshowsState {
  @override
  List<Object> get props => [];
}

class SlideshowsErrorState extends MosaicoSlideshowsState {
  final String message;

  SlideshowsErrorState({required this.message});

  @override
  List<Object> get props => [message];
}