import 'package:equatable/equatable.dart';

abstract class SlideshowsEvent extends Equatable {}

class LoadSlideshowsEvent extends SlideshowsEvent {
  @override
  List<Object> get props => [];
}
