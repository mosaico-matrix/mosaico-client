import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:mosaico/features/slideshows/presentation/widgets/slideshow_editor_item_card/slideshow_editor_item_card_duration.dart';
import 'package:mosaico_flutter_core/core/utils/toaster.dart';
import 'package:mosaico_flutter_core/features/mosaico_slideshows/data/models/mosaico_slideshow_item.dart';
import 'package:mosaico_flutter_core/features/mosaico_widgets/data/models/mosaico_widget.dart';
import 'package:mosaico_flutter_core/features/mosaico_widgets/data/models/mosaico_widget_configuration.dart';
import 'package:mosaico_flutter_core/features/mosaico_widgets/data/repositories/mosaico_widget_configurations_coap_repository.dart';
import 'slideshow_editor_item_card_config_select.dart';
import 'slideshow_editor_item_card_heading.dart';
import 'slideshow_editor_item_card_widget_select.dart';

class SlideshowEditorItemCard extends StatefulWidget {
  final MosaicoSlideshowItem slideshowItem;
  final VoidCallback onDelete;
  final Function(int) onWidgetSelected;
  final Function(int?) onConfigSelected;
  final Function(int) onDurationChanged;
  final int position;

  const SlideshowEditorItemCard(
      {super.key,
      required this.slideshowItem,
      required this.onDelete,
      required this.onWidgetSelected,
      required this.onConfigSelected,
      required this.onDurationChanged,
      required this.position});

  @override
  _SlideshowEditorItemCardState createState() =>
      _SlideshowEditorItemCardState();
}

class _SlideshowEditorItemCardState extends State<SlideshowEditorItemCard> {
  late MosaicoSlideshowItem _slideshowItem;
  List<MosaicoWidgetConfiguration>? _configurations;

  @override
  void initState() {
    super.initState();
    _slideshowItem = widget.slideshowItem;
    getConfigurationsForSelectedWidget();
  }

  void setWidget(MosaicoWidget widget) {
    setState(() {
      _slideshowItem.widgetId = widget.id;
      _slideshowItem.configId = null;
    });
    this.widget.onWidgetSelected(widget.id);
    getConfigurationsForSelectedWidget();
  }

  void getConfigurationsForSelectedWidget() {
    if (_slideshowItem.widgetId == -1) return;

    // Get configurations for the selected widget
    context
        .read<MosaicoWidgetConfigurationsCoapRepository>()
        .getWidgetConfigurations(widgetId: _slideshowItem.widgetId)
        .then((value) {
      setState(() {
        _configurations = null;
        if (value.isNotEmpty) {
          _configurations = value;
        }
      });
    }).catchError((error) {
      Toaster.error("Failed to get configurations for widget");
    });
  }

  void setConfig(MosaicoWidgetConfiguration? config) {
    _slideshowItem.configId = config?.id;
    widget.onConfigSelected(config?.id);
  }

  void setDuration(int secondsDuration) {
    _slideshowItem.secondsDuration = secondsDuration;
    widget.onDurationChanged(secondsDuration);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _buildCard(
          child: Column(
            children: [
              SlideshowEditorItemCardHeading(position: widget.position),
              SlideshowEditorItemCardWidgetSelect(
                initialWidgetId: _slideshowItem.widgetId == -1
                    ? null
                    : _slideshowItem.widgetId,
                setWidget: setWidget,
              ),
              SlideshowEditorItemCardConfigSelect(
                configurations: _configurations,
                setConfig: setConfig,
                initialConfigId: _slideshowItem.configId,
              ),
              SlideshowEditorItemCardDuration(
                initialDuration: _slideshowItem.secondsDuration > 0
                    ? _slideshowItem.secondsDuration
                    : null,
                  onDurationChanged: widget.onDurationChanged)
              //const SlideshowEditorItemCardDuration(),
            ],
          ),
          context: context,
        ),
        _buildDeleteButton(context),
      ],
    );
  }

  Widget _buildCard({required Widget child, required BuildContext context}) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
          child: Container(
            decoration: BoxDecoration(
              border: GradientBoxBorder(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Theme.of(context).colorScheme.secondary,
                    Colors.white.withOpacity(0.6),
                  ],
                ),
                width: 1,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30.0),
            child: child,
          ),
        ),
      ),
    );
  }

  Widget _buildDeleteButton(BuildContext context) {
    return Positioned(
      right: 0,
      top: 0,
      child: IconButton(
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all(Colors.white),
          ),
          onPressed: widget.onDelete,
          icon: const Icon(Icons.delete),
          color: Theme.of(context).colorScheme.error),
    );
  }
}
