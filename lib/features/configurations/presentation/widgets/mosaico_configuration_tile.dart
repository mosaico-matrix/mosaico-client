import 'package:flutter/material.dart';
import 'package:mosaico/shared/widgets/mosaico_tile.dart';
import 'package:mosaico_flutter_core/features/mosaico_widgets/data/models/mosaico_widget_configuration.dart';

class MosaicoConfigurationTile extends StatelessWidget {

  final MosaicoWidgetConfiguration configuration;
  final Widget? trailing;
  const MosaicoConfigurationTile({super.key, required this.configuration, this.trailing});

  @override
  Widget build(BuildContext context) {
    return MosaicoTile(
      child: ListTile(
        title: Text(
            configuration.name,
            style: TextStyle(color: Theme.of(context).colorScheme.primary)),
        trailing: trailing
      ),
    );
  }
}
