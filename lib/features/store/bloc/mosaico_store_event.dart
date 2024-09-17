import 'package:equatable/equatable.dart';

import 'mosaico_store_state.dart';

abstract class MosaicoStoreEvent extends Equatable {}

class LoadMosaicoStoreEvent extends MosaicoStoreEvent {
  @override
  List<Object> get props => [];
}

class InstallMosaicoWidgetEvent extends MosaicoStoreEvent {
  final int storeId;
  final MosaicoStoreLoadedState previousState;

  InstallMosaicoWidgetEvent({required this.storeId, required this.previousState});

  @override
  List<Object> get props => [storeId, previousState];
}