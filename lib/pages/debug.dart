import 'package:flutter/material.dart';
import 'package:mosaico/networking/ble/matrix_service.dart';
import 'package:mosaico/networking/coap/widget_service.dart';

void dumpData(data) {
  print(data);
}

class DebugPage extends StatelessWidget {
  const DebugPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Debug'),
      ),
      body: const SingleChildScrollView(
        child: Column(
          children: <Widget>[
            DebugSection(
              title: 'BLE',
              content: BleSection(),
            ),
            DebugSection(
              title: 'COAP',
              content: CoapSection(),
            ),
          ],
        ),
      ),
    );
  }
}

class BleSection extends StatelessWidget {
  const BleSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        DebugSubSection(title: "Matrix", children: [
          ElevatedButton(
            onPressed: () {
            },
            child: const Text('Send network credentials'),
          ),

        ])
      ],
    );
  }
}

class CoapSection extends StatelessWidget {
  const CoapSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        DebugSubSection(title: "Widgets", children: [
          ElevatedButton(
            onPressed: () {
              WidgetService.installWidget(1);
            },
            child: const Text('Install widget with ID 1'),
          ),

        ])
      ],
    );
  }
}

class DebugSubSection extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const DebugSubSection({super.key, required this.title, required this.children});

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

  const DebugSection({super.key, required this.title, required this.content});

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
