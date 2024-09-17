import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mosaico/features/slideshows/cubits/mosaico_slideshow_cubit.dart';
import 'package:mosaico/features/slideshows/cubits/mosaico_slideshow_item_cubit.dart';
import 'package:mosaico_flutter_core/features/mosaico_slideshows/data/models/mosaico_slideshow_item.dart';
import 'package:mosaico_flutter_core/features/mosaico_widgets/data/models/mosaico_widget.dart';
import 'package:mosaico_flutter_core/features/mosaico_widgets/data/repositories/mosaico_widgets_coap_repository.dart';
import 'package:provider/provider.dart';

class SlideshowEditorItemCardWidgetSelect extends StatelessWidget {
  final int? initialWidgetId;
  final Function(MosaicoWidget) setWidget;

  const SlideshowEditorItemCardWidgetSelect(
      {super.key, required this.setWidget, this.initialWidgetId});

  @override
  Widget build(BuildContext context) {
    try {
      return Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: CustomDropdown<MosaicoWidget>.search(
          hintText: 'Widget',
          items: context
              .read<MosaicoWidgetsCoapRepository>()
              .getInstalledWidgetsFromCache(),
          excludeSelected: false,
          initialItem: initialWidgetId != null
              ? context
                  .read<MosaicoWidgetsCoapRepository>()
                  .getInstalledWidgetsFromCache()
                  .firstWhere((element) => element.id == initialWidgetId)
              : null,
          onChanged: (widget) {
            if (widget == null) return;
            setWidget(widget);
          },
          listItemBuilder: (context, widget, _, __) => Text(widget.name),
          headerBuilder: (context, widget, _) => Text(widget.name),
        ),
      );
    } catch (e) {
      return const Text('The widget that was previously selected is not currently installed.',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.red));
    }
  }
}
