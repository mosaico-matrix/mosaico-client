// import 'package:flutter/material.dart';
// import 'package:mosaico/features/store/presentation/states/store_state.dart';
// import 'package:mosaico/features/store/presentation/widgets/mosaico_store_widget_tile.dart';
// import 'package:mosaico_flutter_core/features/mosaico_loading/presentation/states/mosaico_loading_state.dart';
// import 'package:mosaico_flutter_core/features/mosaico_loading/presentation/widgets/mosaico_loading_indicator.dart';
// import 'package:provider/provider.dart';
// import 'package:mosaico_flutter_core/common/widgets/empty_placeholder.dart';
//
// class LoadingPage<T extends ChangeNotifier> extends StatelessWidget {
//   final String title;
//   final Widget child;
//
//   const LoadingPage({
//     required this.title,
//     required this.child,
//     super.key,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider<T>(
//       create: (context) => stateCreator(context),
//       child: Scaffold(
//         appBar: AppBar(
//           title: Text(title),
//         ),
//         body: Consumer<T>(
//           builder: (context, state, child) {
//             var isLoading = Provider.of<MosaicoLoadingState>(context).isLoading;
//
//             // Get widgets after the widget is built
//             WidgetsBinding.instance.addPostFrameCallback((_) async {
//               await (state as dynamic).init();
//             });
//
//             // Show loading
//             if (isLoading) {
//               return Center(child: MosaicoLoadingIndicator());
//             }
//
//             // Empty
//             if ((state as dynamic).widgets?.isEmpty ?? true) {
//               return const EmptyPlaceholder();
//             }
//
//             // Display widgets
//             return ListView.builder(
//               itemCount: (state as dynamic).widgets?.length ?? 0,
//               itemBuilder: (context, index) {
//                 return itemBuilder(context, state);
//               },
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
//
// // Example usage for WidgetsPage
// class WidgetsPage extends StatelessWidget {
//   const WidgetsPage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return LoadingPage<InstalledWidgetsState>(
//       title: 'Widgets',
//       stateCreator: (context) => InstalledWidgetsState(Provider.of<MosaicoLoadingState>(context, listen: false)),
//       itemBuilder: (context, state) {
//         final widget = (state as InstalledWidgetsState).widgets![index];
//         return MosaicoStoreWidgetTile(widget: widget);
//       },
//     );
//   }
// }
//
// // Example usage for StorePage
// class StorePage extends StatelessWidget {
//   const StorePage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return LoadingPage<StoreState>(
//       title: 'Store',
//       stateCreator: (context) => StoreState(Provider.of<MosaicoLoadingState>(context, listen: false)),
//       itemBuilder: (context, state) {
//         final widget = (state as StoreState).widgets![index];
//         return MosaicoStoreWidgetTile(widget: widget);
//       },
//     );
//   }
// }
