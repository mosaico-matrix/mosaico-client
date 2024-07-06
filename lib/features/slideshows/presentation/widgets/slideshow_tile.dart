import 'package:flutter/material.dart';
import 'package:mosaico/shared/widgets/mosaico_tile.dart';

class SlideshowTile extends StatelessWidget {
  const SlideshowTile({super.key});

  @override
  Widget build(BuildContext context) {
    return MosaicoTile(
      child: ListTile(
        title: const Text("data"),
    ));
  }
}
