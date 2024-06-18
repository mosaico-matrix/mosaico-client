import 'package:flutter/material.dart';
import 'package:mosaico_flutter_core/modules/networking/channels/coap/widgets_service.dart';
import 'package:mosaico_flutter_core/toaster.dart';

void dumpData(data) {
  Toaster.success(data.toString());
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
        DebugSubSection(title: "Install widgets", children: [
          ElevatedButton(
            onPressed: () async {
              await WidgetsService.installWidget(1);
            },
            child: const Text('Install widget with ID 1'),
          ),
          ElevatedButton(
            onPressed: () async {
              await WidgetsService.installWidget(2);
            },
            child: const Text('Install widget with ID 2'),
          ),

          ElevatedButton(
            onPressed: () async {
              var widgets = await WidgetsService.getInstalledWidgets();
              // Create string representation of widgets
              var widgetString = widgets.map((e) => e.name).join('\n');
              dumpData(widgetString);
            },
            child: const Text('Get installed widgets'),
          ),

        ]),

        DebugSubSection(title: "Widget configurations", children: [
          ElevatedButton(
            onPressed: () async {
              
            },
            child: const Text('Add test config to widget 1'),
          ),


        ]),

        DebugSubSection(title: "Active widget", children: [
          ElevatedButton(
            onPressed: () async {

            },
            child: const Text('Get active widget'),
          ),

          ElevatedButton(
            onPressed: () async {
              await WidgetsService.previewWidget(1, 1);
            },
            child: const Text('Set active widget 1 with conf 1'),
          ),
        ]),
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
