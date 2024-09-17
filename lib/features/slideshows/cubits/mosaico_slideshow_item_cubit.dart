import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mosaico/features/slideshows/cubits/mosaico_slideshow_cubit.dart';
import 'package:mosaico_flutter_core/features/mosaico_slideshows/data/models/mosaico_slideshow.dart';
import 'package:mosaico_flutter_core/features/mosaico_slideshows/data/models/mosaico_slideshow_item.dart';
import 'package:mosaico_flutter_core/features/mosaico_slideshows/data/repositories/mosaico_slideshows_coap_repository.dart';
import 'package:mosaico_flutter_core/features/mosaico_widgets/data/models/mosaico_widget.dart';
import 'package:mosaico_flutter_core/features/mosaico_widgets/data/models/mosaico_widget_configuration.dart';
import 'package:mosaico_flutter_core/features/mosaico_widgets/data/repositories/mosaico_widget_configurations_coap_repository.dart';
import 'package:mosaico_flutter_core/features/mosaico_widgets/data/repositories/mosaico_widgets_coap_repository.dart';

class MosaicoSlideshowItemCubit extends Cubit<MosaicoSlideshowItem> {
  final MosaicoSlideshowCubit slideshowCubit;

  MosaicoSlideshowItemCubit(
      {required this.slideshowCubit,
      required MosaicoSlideshowItem initialState})
      : super(initialState);

  void setWidget(MosaicoWidget? widget) {
    emit(updateSlideshowItem(state.copyWith(widgetId: widget?.id, configId: null)));
  }

  void setConfig(MosaicoWidgetConfiguration? config) {
    updateSlideshowItem(state.copyWith(configId: config?.id));
  }

  void setDuration(int secondsDuration) {
    // No need to emit here
    updateSlideshowItem(state.copyWith(secondsDuration: secondsDuration, configId: state.configId));
  }

  MosaicoSlideshowItem updateSlideshowItem(MosaicoSlideshowItem newItem) {
    // Replace the item in the list with updated item
    for (var i = 0; i < slideshowCubit.state.items.length; i++) {
      if (slideshowCubit.state.items[i].position == newItem.position) {
        slideshowCubit.state.items[i] = newItem;
      }
    }
    return newItem;
  }
}
