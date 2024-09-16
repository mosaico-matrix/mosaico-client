import 'package:animated_expandable_fab/animated_expandable_fab.dart';
import 'package:animated_expandable_fab/expandable_fab/action_button.dart';
import 'package:drag_and_drop_lists/drag_and_drop_lists.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mosaico/features/slideshows/cubits/mosaico_slideshow_cubit.dart';
import 'package:mosaico/features/slideshows/presentation/widgets/slideshow_editor_item_card/slideshow_editor_item_card.dart';
import 'package:mosaico_flutter_core/common/widgets/renamable_app_bar.dart';
import 'package:mosaico_flutter_core/features/mosaico_slideshows/data/models/mosaico_slideshow.dart';
import 'package:showcaseview/showcaseview.dart';

class SlideshowEditorPage extends StatelessWidget {
  final MosaicoSlideshow? slideshow;
  final GlobalKey _fabKey = GlobalKey();

  SlideshowEditorPage({Key? key, this.slideshow}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
        value: MosaicoSlideshowCubit(),
        child: Builder(builder: (context) {
          // Show tooltip on first load
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (context.read<MosaicoSlideshowCubit>().state.items.isEmpty) {
              ShowCaseWidget.of(context)
                  .startShowCase([_fabKey]); // Start the showcase
            }
          });
          return Scaffold(
            floatingActionButton: _buildFab(context),
            appBar: RenamableAppBar(
              promptText: "Enter slideshow name",
              askOnLoad: false,
              initialTitle: context.read<MosaicoSlideshowCubit>().state.name,
              onTitleChanged: (String newName) {
                context
                    .read<MosaicoSlideshowCubit>()
                    .updateSlideshowName(newName);
              },
            ),
            body: BlocBuilder<MosaicoSlideshowCubit, MosaicoSlideshow>(
                builder: (context, state) {
              return ListView.builder(
                itemCount: state.items.length,
                itemBuilder: (context, index) {
                  return SlideshowEditorItemCard(
                    // Use a unique key for each item
                    slideshowItem: state.items[index],
                  );
                },
              );
            }),
          );
        }));
  }

  Widget _buildFab(BuildContext context) {
    return ExpandableFab(
      distance: 100,
      openIcon: Showcase(
          overlayOpacity: 0,
          scaleAnimationDuration: const Duration(milliseconds: 200),
          key: _fabKey,
          description: 'Click here to add a new item to the slideshow',
          child: const Icon(Icons.menu)),
      closeBackgroundColor: Colors.white,
      closeIcon: Icon(Icons.close, color: Theme.of(context).colorScheme.error),
      children: [
        ActionButton(
          onPressed: () =>
              context.read<MosaicoSlideshowCubit>().addSlideshowItem(),
          icon: const Icon(Icons.add, color: Colors.white),
        ),
        ActionButton(
          // onPressed: () =>
          //     context.read<MosaicoSlideshowCubit>().saveSlideshow(context),
          icon: const Icon(Icons.save, color: Colors.white),
        ),
        ActionButton(
          // onPressed: () =>
          //     context.read<MosaicoSlideshowCubit>().activateSlideshow(context),
          icon: const Icon(Icons.play_arrow, color: Colors.white),
        ),
      ],
    );
  }
}
