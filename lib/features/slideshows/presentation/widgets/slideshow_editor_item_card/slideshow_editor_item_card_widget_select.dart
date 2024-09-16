import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mosaico/features/slideshows/cubits/mosaico_slideshow_cubit.dart';
import 'package:mosaico/features/slideshows/cubits/mosaico_slideshow_item_cubit.dart';
import 'package:mosaico/features/slideshows/presentation/states/slideshow_state.dart';
import 'package:mosaico_flutter_core/features/mosaico_slideshows/data/models/mosaico_slideshow_item.dart';
import 'package:mosaico_flutter_core/features/mosaico_slideshows/data/repositories/mosaico_slideshows_coap_repository.dart';
import 'package:mosaico_flutter_core/features/mosaico_widgets/data/models/mosaico_widget.dart';
import 'package:mosaico_flutter_core/features/mosaico_widgets/data/repositories/mosaico_widgets_coap_repository.dart';
import 'package:provider/provider.dart';

class SlideshowEditorItemCardWidgetSelect extends StatelessWidget {
  const SlideshowEditorItemCardWidgetSelect({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MosaicoSlideshowItemCubit, MosaicoSlideshowItem>(
        builder: (context, state) {
      return Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: FutureBuilder(
          future: context
              .read<MosaicoWidgetsCoapRepository>()
              .getInstalledWidgets(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return CustomDropdown<MosaicoWidget>.search(
                hintText: 'Widget',
                items: snapshot.data!,
                excludeSelected: false,
                onChanged: (widget) {
                  context.read<MosaicoSlideshowItemCubit>().setWidget(widget);
                },
                listItemBuilder: (context, widget, _, __) => Text(widget.name),
                headerBuilder: (context, widget, _) => Text(widget.name),
              );
            } else {
              // Empty list
              return CustomDropdown<MosaicoWidget>.search(
                hintText: 'Widget',
                items: [],
                excludeSelected: false,
                onChanged: (widget) {},
                listItemBuilder: (context, widget, _, __) => Text(widget.name),
                headerBuilder: (context, widget, _) => Text(widget.name),
              );
            }
          },
        ),
      );
    });
  }

  MosaicoWidget? getWidgetById(List<MosaicoWidget> widgets, int id) {
    for (var widget in widgets) {
      if (widget.id == id) {
        return widget;
      }
    }
    return null;
  }
}
