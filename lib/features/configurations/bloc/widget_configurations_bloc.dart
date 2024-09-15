import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mosaico_flutter_core/features/mosaico_widgets/data/repositories/mosaico_widget_configurations_coap_repository.dart';
import 'widget_configurations_event.dart';
import 'widget_configurations_state.dart';

class WidgetConfigurationsBloc extends Bloc<WidgetConfigurationsEvent, WidgetConfigurationsState> {

  final MosaicoWidgetConfigurationsCoapRepository configurationsRepository;
  WidgetConfigurationsBloc(this.configurationsRepository) : super(WidgetConfigurationsInitialState()){
    on<LoadWidgetConfigurationsEvent>(_onLoadConfigurations);
  }

  Future<void> _onLoadConfigurations(LoadWidgetConfigurationsEvent event, Emitter<WidgetConfigurationsState> emit) async {
    emit(WidgetConfigurationsLoadingState());
    try {
      final configurations = await configurationsRepository.getWidgetConfigurations(widgetId: event.widgetId);
      emit(WidgetConfigurationsLoadedState(configurations: configurations));
    } catch (e) {
      emit(WidgetConfigurationsErrorState(message: e.toString()));
    }
  }
}