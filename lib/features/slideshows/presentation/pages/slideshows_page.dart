import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mosaico/features/slideshows/bloc/mosaico_slideshows_bloc.dart';
import 'package:mosaico/features/slideshows/bloc/mosaico_slideshows_event.dart';
import 'package:mosaico/features/slideshows/bloc/mosaico_slideshows_state.dart';
import 'package:mosaico/features/widgets/bloc/mosaico_installed_widgets_bloc.dart';
import 'package:mosaico/features/widgets/bloc/mosaico_installed_widgets_state.dart';
import 'package:mosaico_flutter_core/common/widgets/empty_placeholder.dart';
import 'package:mosaico_flutter_core/common/widgets/matrices/loading_matrix.dart';
import 'package:mosaico_flutter_core/features/matrix_control/bloc/matrix_device_bloc.dart';
import 'package:mosaico_flutter_core/features/matrix_control/bloc/matrix_device_state.dart';
import '../widgets/slideshow_tile.dart';

class SlideshowsPage extends StatelessWidget {
  const SlideshowsPage({super.key});

  @override
  Widget build(BuildContext context) {

    // Only if never loaded before, load slideshows
    if (context.read<MosaicoSlideshowsBloc>().state is SlideshowsInitialState) {

      // Check before if matrix is connected
      if (context.read<MatrixDeviceBloc>().state is MatrixDeviceConnectedState) {
        context.read<MosaicoSlideshowsBloc>().add(LoadSlideshowsEvent());
      }
    }

    return BlocListener<MosaicoInstalledWidgetsBloc,
        MosaicoInstalledWidgetsState>(
      listener: (context, state) {
        // Refresh slideshows when got installed widgets again
        // This could potentially mean we connected to a new matrix or that we tried to load
        // slideshows before the widgets were loaded
        if (state is MosaicoInstalledWidgetsLoaded) {
          context.read<MosaicoSlideshowsBloc>().add(LoadSlideshowsEvent());
        }
      },
      child: BlocBuilder<MosaicoSlideshowsBloc, MosaicoSlideshowsState>(
          builder: (context, state) {

        // Loading
        if (state is SlideshowsLoadingState) {
          return Center(child: LoadingMatrix());
        }

        // Loaded
        if (state is SlideshowsLoadedState) {
          return Center(
            child: ListView.builder(
              padding: const EdgeInsets.all(0),
              itemCount: state.slideshows.length,
              itemBuilder: (context, index) {
                return SlideshowTile(slideshow: state.slideshows[index]);
              },
            ),
          );
        }

        // Error
        if (state is SlideshowsErrorState) {
          return EmptyPlaceholder(
            hintText: state.message,
            onRetry: () {
              context.read<MosaicoSlideshowsBloc>().add(LoadSlideshowsEvent());
            },
          );
        }

        // No slideshows
        if (state is NoSlideshowsState) {
          return const EmptyPlaceholder(
            hintText: "Create a new slideshow by clicking the button below",
          );
        }

        return const EmptyPlaceholder(
            hintText: "Connect to matrix to load and create slideshows");
      }),
    );
  }
}
