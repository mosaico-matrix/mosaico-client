import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mosaico_flutter_core/features/mosaico_slideshows/data/models/mosaico_slideshow_item.dart';
import 'package:mosaico_flutter_core/features/mosaico_widgets/data/models/mosaico_widget.dart';
import 'package:mosaico_flutter_core/features/mosaico_widgets/data/models/mosaico_widget_configuration.dart';

class MosaicoSlideshowItemCubit extends Cubit<MosaicoSlideshowItem> {
  MosaicoSlideshowItemCubit({required MosaicoSlideshowItem initialState})
      : super(initialState);

  void setWidget(MosaicoWidget? widget) {
    emit(state.copyWith(widgetId: widget?.id, configId: null));
  }

  void setConfig(MosaicoWidgetConfiguration? config) {
    state.configId = config?.id;
  }

  void setDuration(int secondsDuration) {
    state.secondsDuration = secondsDuration;
  }
}
