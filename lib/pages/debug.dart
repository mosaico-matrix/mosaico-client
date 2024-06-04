import 'package:flutter/material.dart';
import 'package:magicsquare/services/ble/runner_service.dart';

void dumpData(data) {
  print(data);
}

class DebugPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Debug'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            DebugSection(
              title: 'BLE',
              content: BleSection(),
            ),
            DebugSection(
              title: 'Network',
              content: NetworkSection(),
            ),
          ],
        ),
      ),
    );
  }
}

class BleSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[

        // Runner
        DebugSubSection(title: "Runner", children: [
          ElevatedButton(
            onPressed: () {

            },
            child: const Text('Test'),
          ),

        ])
      ],
    );
  }
}

class NetworkSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Column(
      children: <Widget>[
        Text('Network Debug Information'),
      ],
    );
  }
}

class DebugSubSection extends StatelessWidget {
  final String title;
  final List<Widget> children;

  DebugSubSection({required this.title, required this.children});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const Divider(),
        ...children,
      ],
    );
  }
}



class DebugSection extends StatelessWidget {
  final String title;
  final Widget content;

  DebugSection({required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: content,
            ),
          ],
        ),
      ),
    );
  }
}
