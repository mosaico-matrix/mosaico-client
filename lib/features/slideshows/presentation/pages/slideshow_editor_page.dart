import 'package:animated_expandable_fab/animated_expandable_fab.dart';
import 'package:animated_expandable_fab/expandable_fab/action_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mosaico/features/slideshows/bloc/mosaico_slideshows_bloc.dart';
import 'package:mosaico/features/slideshows/bloc/mosaico_slideshows_event.dart';
import 'package:mosaico/features/slideshows/cubits/mosaico_slideshow_cubit.dart';
import 'package:mosaico/features/slideshows/presentation/widgets/slideshow_editor_item_card/slideshow_editor_item_card.dart';
import 'package:mosaico/shared/widgets/pixel_rain.dart';
import 'package:mosaico_flutter_core/common/widgets/renamable_app_bar.dart';
import 'package:mosaico_flutter_core/core/extensions/build_context_extensions.dart';
import 'package:mosaico_flutter_core/core/utils/toaster.dart';
import 'package:mosaico_flutter_core/features/mosaico_slideshows/data/models/mosaico_slideshow.dart';
import 'package:mosaico_flutter_core/features/mosaico_slideshows/data/repositories/mosaico_slideshows_coap_repository.dart';
import 'package:mosaico_flutter_core/features/mosaico_widgets/data/repositories/mosaico_widget_configurations_coap_repository.dart';
import 'package:showcaseview/showcaseview.dart';

class SlideshowEditorPage extends StatelessWidget {

  late MosaicoSlideshow slideshow;
  final GlobalKey _fabKey = GlobalKey();
  SlideshowEditorPage({Key? key, MosaicoSlideshow? slideshow})
      : super(key: key) {
    this.slideshow = slideshow ?? MosaicoSlideshow();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
        value: MosaicoSlideshowCubit(slideshow),
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
            body: PixelRain(
              child: BlocBuilder<MosaicoSlideshowCubit, MosaicoSlideshow>(
                  builder: (context, state) {
                return ListView.builder(
                  itemCount: state.items.length,
                  itemBuilder: (context, index) {
                    return SlideshowEditorItemCard(
                      slideshowItem: state.items[index],
                    );
                  },
                );
              }),
            ),
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
          onPressed: () async {

            context.showLoading();

            // Validate slideshow
            if(!await _validateSlideshow(context)) {
              context.hideLoading();
              return;
            }

            // Save slideshow
            context
                .read<MosaicoSlideshowsCoapRepository>()
                .createOrUpdateSlideshow(context.read<MosaicoSlideshowCubit>().state)
                .whenComplete(() => context.hideLoading())
                .then((value) {
                  context.read<MosaicoSlideshowsBloc>().add(LoadSlideshowsEvent());
            })
                .catchError((error) {
              Toaster.error("Failed to save slideshow");
            });
          },
          icon: const Icon(Icons.save, color: Colors.white),
        ),

        // Show only if the slideshow is saved
        if(context.read<MosaicoSlideshowCubit>().state.id != null)
        ActionButton(
          icon: const Icon(Icons.play_arrow, color: Colors.white),
          onPressed: () async {
            context.showLoading();
            context
                .read<MosaicoSlideshowsCoapRepository>()
                .setActiveSlideshow(slideshow.id!)
                .whenComplete(() => context.hideLoading())
                .catchError((error) {
              Toaster.error("Error playing slideshow");
            });
          },
        ),
      ],
    );

  }

  Future<bool> _validateSlideshow(BuildContext context) async {

    var slideshow = context.read<MosaicoSlideshowCubit>().state;

    if (slideshow.name.isEmpty) {
      Toaster.error("Slideshow name cannot be empty");
      return false;
    }

    if (slideshow.items.isEmpty || slideshow.items.length < 2) {
      Toaster.error("Slideshow must have at least 2 items");
      return false;
    }

    for (var item in slideshow.items) {

      // Didn't select a widget
      if (item.widgetId == -1) {
        Toaster.error("All items must have a widget");
        return false;
      }

      // Didn't select a configuration for a configurable widget
      var widgetConfigurable = await context
          .read<MosaicoWidgetConfigurationsCoapRepository>()
          .isWidgetConfigurable(widgetId: item.widgetId);
      if (item.configId == null && widgetConfigurable) {
        Toaster.error("You didn't select a configuration for a widget");
        return false;
      }

      // WTF
      if (item.secondsDuration < 1 || item.secondsDuration > 999999999) {
        Toaster.error("Duration must be greater than 0");
        return false;
      }
    }

    return true;
  }
}
