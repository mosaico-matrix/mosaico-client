import 'package:animated_expandable_fab/expandable_fab/action_button.dart';
import 'package:animated_expandable_fab/expandable_fab/expandable_fab.dart';
import 'package:flutter/material.dart';
import 'package:mosaico/features/slideshows/presentation/widgets/slideshow_editor.dart';
import 'package:mosaico_flutter_core/common/widgets/renamable_app_bar.dart';
import 'package:mosaico_flutter_core/features/mosaico_slideshows/data/models/mosaico_slideshow.dart';
import 'package:provider/provider.dart';
import '../../../../shared/widgets/loadable_page.dart';
import '../states/slideshow_state.dart';

class SlideshowPage extends StatelessWidget {

  const SlideshowPage({super.key});

  @override
  Widget build(BuildContext context) {

    return Container();
    // This is the edit item in the case of editing a slideshow
    //var editingSlideshow = ModalRoute.of(context)!.settings.arguments as MosaicoSlideshow?;

    // return ChangeNotifierProvider(
    //   create: (context) =>
    //       SlideshowState(editingSlideshow),
    //   child: Consumer<SlideshowState>(
    //     builder: (context, slideshowState, _) => Scaffold(
    //       body: LoadablePage<SlideshowState>(
    //         noDataHintText: "Try to add a new item with the button below",
    //         appBar: RenamableAppBar(
    //           promptText: "Enter slideshow name",
    //           askOnLoad: editingSlideshow == null,
    //           initialTitle: slideshowState.getSlideshowName(),
    //           onTitleChanged: (String newName) {
    //             slideshowState.setSlideshowName(newName);
    //           },
    //         ),
    //         fab: ExpandableFab(
    //             distance: 100,
    //             openIcon: const Icon(Icons.menu),
    //             closeBackgroundColor: Colors.white,
    //             closeIcon: Icon(Icons.close, color: Theme.of(context).colorScheme.error),
    //             children: [
    //               ActionButton(
    //                 onPressed: () => slideshowState.addSlideshowItem(),
    //                icon: const Icon(Icons.add, color: Colors.white),
    //               ),
    //               ActionButton(
    //                 onPressed: () => slideshowState.saveSlideshow(context),
    //                 icon: const Icon(Icons.save, color: Colors.white),
    //               ),
    //               ActionButton(
    //                 onPressed: () => slideshowState.activateSlideshow(context),
    //                 icon: const Icon(Icons.play_arrow, color: Colors.white),
    //               ),
    //             ],
    //           ),
    //
    //
    //
    //         state: slideshowState,
    //         child: const SlideshowEditor(),
    //       )
    //     ),
    //   ),
    // );
  }
}
