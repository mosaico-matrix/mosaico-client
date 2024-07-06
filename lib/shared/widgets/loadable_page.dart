import 'package:flutter/material.dart';
import 'package:mosaico/features/store/presentation/states/store_state.dart';
import 'package:mosaico/features/store/presentation/widgets/mosaico_store_widget_tile.dart';
import 'package:mosaico/shared/states/loadable_state.dart';
import 'package:mosaico_flutter_core/features/mosaico_loading/presentation/states/mosaico_loading_state.dart';
import 'package:mosaico_flutter_core/features/mosaico_loading/presentation/widgets/mosaico_loading_indicator.dart';
import 'package:parallax_rain/parallax_rain.dart';
import 'package:provider/provider.dart';
import 'package:mosaico_flutter_core/common/widgets/empty_placeholder.dart';

/// This is a generic loading page that shows a loading indicator while the state is loading
/// This also shows an empty placeholder if the resource of the state is empty
/// The state must extend [LoadableState]
/// This also calls the init method of the state after the widget is built
class LoadablePage<T extends LoadableState> extends StatelessWidget {
  final Widget? heading;
  final Widget child;
  final String? noDataHintText;
  final T state;

  const LoadablePage({
    this.heading,
    required this.child,
    required this.state,
    this.noDataHintText,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // Set loading state
    var loadingState = Provider.of<MosaicoLoadingState>(context);
    state.setLoadingState(loadingState);

    // Call init after the widget is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      state.init();
    });

    return ChangeNotifierProvider<T>(
      create: (context) => state,
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: heading == null ? null : AppBar(title: heading),
        body: ParallaxRain(
          numberOfDrops: 50,
          dropFallSpeed: 0.2,
          dropHeight: 0.8,
          dropColors: [
            Colors.red,
            Colors.green,
            Colors.blue,
            Colors.yellow,
          ],
          child: loadingState.isLoading
              ?

              // Loading
              Center(child: MosaicoLoadingIndicator())
              : (state.empty()
                  ?

                  // Empty
                  EmptyPlaceholder(hintText: noDataHintText)
                  : child),
        ),
      ),
    );
  }
}
