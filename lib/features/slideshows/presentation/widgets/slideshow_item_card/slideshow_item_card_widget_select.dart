import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:mosaico/features/slideshows/presentation/states/slideshow_state.dart';
import 'package:mosaico_flutter_core/features/mosaico_slideshows/data/models/mosaico_slideshow_item.dart';
import 'package:mosaico_flutter_core/features/mosaico_widgets/data/models/mosaico_widget.dart';
import 'package:provider/provider.dart';


class SlideshowItemCardWidgetSelect extends StatelessWidget {

  final MosaicoSlideshowItem slideshowItem;
  const SlideshowItemCardWidgetSelect({super.key, required this.slideshowItem});

  @override
  Widget build(BuildContext context) {
    return Container();
    // return Consumer<InstalledWidgetsState>(
    //   builder: (context, installedWidgetsState, _) {
    //     return CustomDropdown<MosaicoWidget>.search(
    //       hintText: 'Widget',
    //       items: installedWidgetsState.widgets,
    //       excludeSelected: false,
    //       onChanged: (widget) {
    //         var slideshowState = Provider.of<SlideshowState>(context, listen: false);
    //         slideshowState.updateItemWidget(slideshowItem, widget);
    //       },
    //       initialItem: installedWidgetsState.getWidgetById(slideshowItem.widgetId),
    //       listItemBuilder: (context, widget, _, __) => Text(widget.name),
    //       headerBuilder: (context, widget, _) => Text(widget.name),
    //     );
    //   },
    // );
  }
}
