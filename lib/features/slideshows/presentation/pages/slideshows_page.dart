import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mosaico/features/slideshows/bloc/slideshows_bloc.dart';
import 'package:mosaico/features/slideshows/bloc/slideshows_event.dart';
import 'package:mosaico/features/slideshows/bloc/slideshows_state.dart';
import 'package:mosaico/features/slideshows/presentation/pages/slideshow_editor_page.dart';
import 'package:mosaico/main.dart';
import 'package:mosaico_flutter_core/common/widgets/empty_placeholder.dart';
import 'package:mosaico_flutter_core/common/widgets/matrices/loading_matrix.dart';
import 'package:mosaico_flutter_core/common/widgets/matrices/no_data_matrix.dart';
import 'package:provider/provider.dart';
import '../../../../shared/widgets/loadable_page.dart';
import '../widgets/slideshow_tile.dart';

class SlideshowsPage extends StatelessWidget {
  const SlideshowsPage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<SlideshowsBloc>().add(LoadSlideshowsEvent());
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => SlideshowEditorPage()));
        },
        child: const Icon(Icons.add),
      ),
      body: BlocBuilder<SlideshowsBloc, SlideshowsState>(
        builder: (context, state) {
          if (state is SlideshowsLoadingState) {
            return Center(child: LoadingMatrix());
          }
          if (state is SlideshowsLoadedState) {
            return ListView.builder(
              padding: const EdgeInsets.all(0),
              itemCount: state.slideshows.length,
              itemBuilder: (context, index) {
                return SlideshowTile(slideshow: state.slideshows[index]);
              },
            );
          }
          if (state is SlideshowsErrorState) {
            return EmptyPlaceholder(
              hintText: state.message,
              onRetry: () {
                context.read<SlideshowsBloc>().add(LoadSlideshowsEvent());
              },
            );
          }
          if (state is NoSlideshowsState) {
            return const EmptyPlaceholder(
              hintText:
                  "Create a new slideshow by clicking the button below",
            );
          }

          return Container();
        },
      ),
    );

    // return LoadablePage<SlideshowsState>(
    //   noDataHintText:
    //       "A slideshow is just a sequence of widgets, try to create one by clicking the button below",
    //   fab: FloatingActionButton(
    //     onPressed: () {
    //       Navigator.pushNamed(context, Routes.slideshow).then(
    //         (value) =>
    //             Provider.of<SlideshowsState>(context, listen: false).render(),
    //       );
    //     },
    //     child: const Icon(Icons.add),
    //   ),
    //   state: Provider.of(context, listen: false),
    //   child: Consumer<SlideshowsState>(
    //     builder: (context, slideshowsState, _) {
    //
    //     },
    //   ),
    // );
  }
}
