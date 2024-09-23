import 'package:animated_expandable_fab/animated_expandable_fab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mosaico/features/slideshows/bloc/mosaico_slideshows_bloc.dart';
import 'package:mosaico/features/slideshows/bloc/mosaico_slideshows_event.dart';
import 'package:mosaico/features/slideshows/presentation/widgets/slideshow_editor_item_card/slideshow_editor_item_card.dart';
import 'package:mosaico/shared/widgets/pixel_rain.dart';
import 'package:mosaico_flutter_core/common/widgets/renamable_app_bar.dart';
import 'package:mosaico_flutter_core/core/extensions/build_context_extensions.dart';
import 'package:mosaico_flutter_core/core/utils/toaster.dart';
import 'package:mosaico_flutter_core/features/mosaico_slideshows/data/models/mosaico_slideshow.dart';
import 'package:mosaico_flutter_core/features/mosaico_slideshows/data/models/mosaico_slideshow_item.dart';
import 'package:mosaico_flutter_core/features/mosaico_slideshows/data/repositories/mosaico_slideshows_coap_repository.dart';
import 'package:mosaico_flutter_core/features/mosaico_widgets/data/repositories/mosaico_widget_configurations_coap_repository.dart';
import 'package:showcaseview/showcaseview.dart';

class SlideshowEditorPage extends StatefulWidget {
  final MosaicoSlideshow? slideshow;

  const SlideshowEditorPage({super.key, this.slideshow});

  @override
  _SlideshowEditorPageState createState() => _SlideshowEditorPageState();
}

class _SlideshowEditorPageState extends State<SlideshowEditorPage> {
  late MosaicoSlideshow slideshow;
  final GlobalKey _fabKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    slideshow = widget.slideshow ?? MosaicoSlideshow();
    if(slideshow.items.isEmpty) {
      addSlideshowItem();
      WidgetsBinding.instance.addPostFrameCallback(
            (_) => ShowCaseWidget.of(context).startShowCase([_fabKey]),
      );
    }
  }

  void addSlideshowItem() {
    setState(() {
      slideshow.items
          .add(MosaicoSlideshowItem(position: slideshow.items.length));
    });
  }

  void saveSlideshow() async {
    context.showLoading();

    // Validate slideshow
    if (!await _validateSlideshow(context, slideshow)) {
      context.hideLoading();
      return;
    }

    // Save slideshow
    context
        .read<MosaicoSlideshowsCoapRepository>()
        .createOrUpdateSlideshow(slideshow)
        .whenComplete(() => context.hideLoading())
        .then((value) {
          slideshow.id = value.id;
      context.read<MosaicoSlideshowsBloc>().add(LoadSlideshowsEvent());
    }).catchError((error) {
      Toaster.error("Failed to save slideshow");
    });
  }

  void playSlideshow() async {

    // Save first
    saveSlideshow();

    context.showLoading();
    context
        .read<MosaicoSlideshowsCoapRepository>()
        .setActiveSlideshow(slideshow.id!)
        .whenComplete(() => context.hideLoading())
        .catchError((error) {
      Toaster.error("Error playing slideshow");
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
          floatingActionButton: _buildFab(context),
          appBar: RenamableAppBar(
            promptText: "Enter slideshow name",
            askOnLoad: false,
            initialTitle: slideshow.name,
            onTitleChanged: (String newName) {
              slideshow.name = newName;
            },
          ),
          body: PixelRain(
            child: ReorderableListView.builder(
              itemCount: slideshow.items.length,
              onReorder: (oldIndex, newIndex) {
                setState(() {
                  if (newIndex > oldIndex) {
                    newIndex -= 1;
                  }
                  final item = slideshow.items.removeAt(oldIndex);
                  item.position = newIndex;
                  slideshow.items.insert(newIndex, item);
                });
              },
              itemBuilder: (context, index) {
                return SlideshowEditorItemCard(
                  key: ValueKey(slideshow.items[index]),
                  // Assign a unique key
                  slideshowItem: slideshow.items[index],
                  position: index,
                  onDelete: () {
                    setState(() {
                      slideshow.items.removeAt(index);
                    });
                  },
                  onWidgetSelected: (widgetId) {
                    slideshow.items[index].widgetId = widgetId;
                    slideshow.items[index].configId = null;
                  },
                  onConfigSelected: (configId) {
                    slideshow.items[index].configId = configId;
                  },
                  onDurationChanged: (seconds) {
                    slideshow.items[index].secondsDuration = seconds;
                  },
                );
              },
            ),
          )),
    );
  }

  Widget _buildFab(BuildContext context) {
    return ExpandableFab(
      distance: 100,
      openIcon: Showcase(
        overlayOpacity: 0,
        scaleAnimationDuration: const Duration(milliseconds: 200),
        key: _fabKey,
        description: 'Click here to add a new item to the slideshow',
        child: const Icon(Icons.menu),
      ),
      closeBackgroundColor: Colors.white,
      closeIcon: Icon(Icons.close, color: Theme
          .of(context)
          .colorScheme
          .error),
      children: [
        ActionButton(
            onPressed: addSlideshowItem,
            icon: const Icon(Icons.add, color: Colors.white)),
        ActionButton(
          onPressed: saveSlideshow,
          icon: const Icon(Icons.save, color: Colors.white),
        ),
        ActionButton(
          onPressed: playSlideshow,
          icon: const Icon(Icons.play_arrow, color: Colors.white),
        ),
      ],
    );
  }


}

Future<bool> _validateSlideshow(BuildContext context, MosaicoSlideshow slideshow) async {

  if (slideshow.name.isEmpty) {
    Toaster.error("Slideshow name cannot be empty");
    return false;
  }

  if (slideshow.items.isEmpty || slideshow.items.length < 2) {
    Toaster.error("Slideshow must have at least 2 items");
    return false;
  }

  for (var item in slideshow.items) {
    if (item.widgetId == -1) {
      Toaster.error("All items must have a widget");
      return false;
    }

    var widgetConfigurable = await context
        .read<MosaicoWidgetConfigurationsCoapRepository>()
        .isWidgetConfigurable(widgetId: item.widgetId);
    if (item.configId == null && widgetConfigurable) {
      Toaster.error("You didn't select a configuration for a widget");
      return false;
    }

    if (item.secondsDuration < 5 || item.secondsDuration > 999999999) {
      Toaster.error("All items must have a duration of at least 5 seconds");
      return false;
    }
  }

  return true;
}
