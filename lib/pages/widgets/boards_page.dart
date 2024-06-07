import 'package:flutter/material.dart';

class BoardsPage extends StatelessWidget {
  const BoardsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Boards'),
      ),
      body: const Center(
        child: Text('Boards'),
      ),
    );
  }
}