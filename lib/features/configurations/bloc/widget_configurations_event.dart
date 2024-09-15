import 'package:equatable/equatable.dart';

abstract class WidgetConfigurationsEvent extends Equatable {}

class LoadWidgetConfigurationsEvent extends WidgetConfigurationsEvent {

  final int widgetId;

  LoadWidgetConfigurationsEvent({required this.widgetId});

  @override
  List<Object?> get props => [widgetId];
}