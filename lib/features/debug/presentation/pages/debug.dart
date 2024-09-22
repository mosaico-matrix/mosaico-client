import 'package:flutter/material.dart';
import 'package:mosaico_flutter_core/core/utils/toaster.dart';

import '../widgets/sections/ble_section.dart';
import '../widgets/sections/coap_section.dart';

void dumpData(data) {
  Toaster.info(data.toString());
}

class DebugPage extends StatelessWidget {
  const DebugPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Debug'),
        ),
        body: Column(children: [
          ElevatedButton(
            onPressed: () => Toaster.success("Success"),
            child: Text("Success"),
          ),
          ElevatedButton(
            onPressed: () => Toaster.warning("Warning"),
            child: Text("Warning"),
          ),
          ElevatedButton(
            onPressed: () => Toaster.error("Error"),
            child: Text("Error"),
          ),
          ElevatedButton(
            onPressed: () => Toaster.info("Info"),
            child: Text("Info"),
          )
        ])

        // SingleChildScrollView(
        //   child: Column(
        //     children: <Widget>[
        //       const DebugSection(
        //         title: 'BLE',
        //         content: BleSection(),
        //       ),
        //       DebugSection(
        //         title: 'COAP',
        //         content: CoapSection(),
        //       ),
        //     ],
        //   ),
        // ),
        );
  }
}

class DebugSubSection extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const DebugSubSection(
      {super.key, required this.title, required this.children});

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
