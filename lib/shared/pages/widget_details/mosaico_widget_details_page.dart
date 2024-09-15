import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mosaico/shared/pages/widget_details/widgets/mosaico_widget_description.dart';
import 'package:mosaico/shared/pages/widget_details/widgets/mosaico_widget_images_carousel.dart';
import 'package:mosaico/shared/pages/widget_details/widgets/mosaico_widget_info.dart';
import 'package:mosaico_flutter_core/common/widgets/empty_placeholder.dart';
import 'package:mosaico_flutter_core/common/widgets/matrices/loading_matrix.dart';
import 'package:mosaico_flutter_core/features/mosaico_widgets/data/models/mosaico_widget.dart';
import 'package:mosaico_flutter_core/features/mosaico_widgets/data/repositories/mosaico_widgets_rest_repository.dart';
import 'package:provider/provider.dart';

import '../../widgets/loadable_page.dart';

class MosaicoWidgetDetailsPage extends StatelessWidget {
  static const double spacing = 16;

  const MosaicoWidgetDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Get widget from arguments
    final selectedWidget =
        ModalRoute.of(context)!.settings.arguments as MosaicoWidget;

    return Scaffold(
        appBar: AppBar(
            title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            CachedNetworkImage(
              imageUrl: selectedWidget.iconUrl,
              width: 32,
              height: 32,
            ),
            const SizedBox(width: 12),
            Text(selectedWidget.name),
          ],
        )),
        body: FutureBuilder(
            future: context
                .read<MosaicoWidgetsRestRepository>()
                .getWidgetDetails(storeId: selectedWidget.id),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return _buildWidgetDetails(snapshot.data!);
              } else if (snapshot.hasError) {
                return EmptyPlaceholder(
                    hintText:
                        "Could not fetch widget from store: ${snapshot.error.toString()}");
              }
              return Center(child: LoadingMatrix());
            }));
  }

  Widget _buildWidgetDetails(MosaicoWidget widget) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image carousel with no padding
          const SizedBox(height: spacing),
          MosaicoWidgetImagesCarousel(images: widget.images),
          const SizedBox(height: spacing),
          Padding(
            padding: const EdgeInsets.all(spacing),
            child: Column(
              children: [
                MosaicoWidgetDescription(description: widget.description),
                const SizedBox(height: spacing),
                MosaicoWidgetInfo(mosaicoWidget: widget),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
