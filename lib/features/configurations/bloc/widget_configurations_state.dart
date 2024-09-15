import 'package:equatable/equatable.dart';
import 'package:mosaico_flutter_core/features/mosaico_widgets/data/models/mosaico_widget_configuration.dart';

abstract class WidgetConfigurationsState extends Equatable {}

class WidgetConfigurationsInitialState extends WidgetConfigurationsState
{
  @override
  List<Object?> get props => [];
}

class WidgetConfigurationsLoadingState extends WidgetConfigurationsState
{
  @override
  List<Object?> get props => [];
}


class WidgetConfigurationsLoadedState extends WidgetConfigurationsState
{
  final List<MosaicoWidgetConfiguration> configurations;

  WidgetConfigurationsLoadedState({required this.configurations});

  @override
  List<Object?> get props => [configurations];

}

class WidgetConfigurationsErrorState extends WidgetConfigurationsState
{
  final String message;

  WidgetConfigurationsErrorState({required this.message});

  @override
  List<Object?> get props => [message];

}
