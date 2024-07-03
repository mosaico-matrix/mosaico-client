import 'package:flutter/material.dart';
import 'package:mosaico/features/store/presentation/states/store_state.dart';
import 'package:mosaico/features/store/presentation/widgets/mosaico_store_widget_tile.dart';
import 'package:mosaico/shared/states/loadable_state.dart';
import 'package:mosaico_flutter_core/features/mosaico_loading/presentation/states/mosaico_loading_state.dart';
import 'package:mosaico_flutter_core/features/mosaico_loading/presentation/widgets/mosaico_loading_indicator.dart';
import 'package:provider/provider.dart';
import 'package:mosaico_flutter_core/common/widgets/empty_placeholder.dart';

/// This is a generic loading page that shows a loading indicator while the state is loading
/// This also shows an empty placeholder if the resource of the state is empty
/// The state must extend [LoadableState]
/// This also calls the init method of the state after the widget is built
class LoadablePage<T extends LoadableState> extends StatelessWidget {
  final String title;
  final Widget child;
  final T state;

  const LoadablePage({
    required this.title,
    required this.child,
    required this.state,
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
        appBar: AppBar(
          title: Text(title),
        ),
        body: loadingState.isLoading
            ?

            // Loading
            Center(child: MosaicoLoadingIndicator())
            : (state.empty()
                ?

                // Empty
                const EmptyPlaceholder()
                : child),
      ),
    );
  }
}
