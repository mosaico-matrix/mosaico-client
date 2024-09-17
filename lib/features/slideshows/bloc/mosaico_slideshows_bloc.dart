import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mosaico_flutter_core/features/mosaico_slideshows/data/repositories/mosaico_slideshows_coap_repository.dart';

import 'mosaico_slideshows_event.dart';
import 'mosaico_slideshows_state.dart';

class MosaicoSlideshowsBloc extends Bloc<MosaicoSlideshowsEvent, MosaicoSlideshowsState> {
  final MosaicoSlideshowsCoapRepository repository;

  MosaicoSlideshowsBloc({required this.repository}) : super(SlideshowsInitialState()) {
    on<LoadSlideshowsEvent>(_onLoadSlideshowsEvent);
  }

  FutureOr<void> _onLoadSlideshowsEvent(
      LoadSlideshowsEvent event, Emitter<MosaicoSlideshowsState> emit) async {
    emit(SlideshowsLoadingState());
    try {
      var slideshows = await repository.getSlideshows();
      if (slideshows.isEmpty) {
        emit(NoSlideshowsState());
      } else {
        emit(SlideshowsLoadedState(slideshows: slideshows));
      }
    } catch (e) {
      emit(SlideshowsErrorState(message: "Error loading slideshows"));
    }
  }
}
