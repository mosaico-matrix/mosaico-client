import 'package:flutter/material.dart';

class MosaicoConfigurationTile extends StatelessWidget {
  const MosaicoConfigurationTile({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text('Configuration'),
      trailing: IconButton(
        icon: const Icon(Icons.delete),
        onPressed: () => print('Delete configuration'),
      ),
    );
  }
}
