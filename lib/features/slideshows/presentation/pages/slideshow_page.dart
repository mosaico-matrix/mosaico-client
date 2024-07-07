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

    // This is the edit item in the case of editing a slideshow
    var editingSlideshow = ModalRoute.of(context)!.settings.arguments as MosaicoSlideshow?;

    return ChangeNotifierProvider(
      create: (context) =>
          SlideshowState(editingSlideshow),
      child: Consumer<SlideshowState>(
        builder: (context, slideshowState, _) => Scaffold(
          body: LoadablePage<SlideshowState>(
            noDataHintText: "Try to add a new item with the button below",
            appBar: RenamableAppBar(
              promptText: "Enter slideshow name",
              askOnLoad: true,
              initialTitle: slideshowState.getSlideshowName(),
              onTitleChanged: (String newName) {
                slideshowState.setSlideshowName(newName);
              },
            ),
            fab: FloatingActionButton(
              onPressed: () => slideshowState.addSlideshowItem(),
              child: const Icon(Icons.add),
            ),
            state: slideshowState,
            child: const SlideshowEditor(),
          )
        ),
      ),
    );
  }
}
