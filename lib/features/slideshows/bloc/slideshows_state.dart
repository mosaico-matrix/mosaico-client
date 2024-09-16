import 'package:equatable/equatable.dart';
import 'package:mosaico_flutter_core/features/mosaico_slideshows/data/models/mosaico_slideshow.dart';

abstract class SlideshowsState extends Equatable {}

class SlideshowsInitialState extends SlideshowsState {
  @override
  List<Object> get props => [];
}

class SlideshowsLoadingState extends SlideshowsState {
  @override
  List<Object> get props => [];
}

class SlideshowsLoadedState extends SlideshowsState {
  final List<MosaicoSlideshow> slideshows;

  SlideshowsLoadedState({required this.slideshows});

  @override
  List<Object> get props => [slideshows];
}

class NoSlideshowsState extends SlideshowsState {
  @override
  List<Object> get props => [];
}

class SlideshowsErrorState extends SlideshowsState {
  final String message;

  SlideshowsErrorState({required this.message});

  @override
  List<Object> get props => [message];
}