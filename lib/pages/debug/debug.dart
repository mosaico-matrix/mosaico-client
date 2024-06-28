import 'package:flutter/material.dart';
import 'package:mosaico/pages/debug/widgets/sections/ble_section.dart';
import 'package:mosaico/pages/debug/widgets/sections/coap_section.dart';
import 'package:mosaico_flutter_core/modules/config_form/models/config_output.dart';
import 'package:mosaico_flutter_core/modules/config_form/pages/config_generator.dart';
import 'package:mosaico_flutter_core/modules/networking/channels/coap/widget_configurations_service.dart';
import 'package:mosaico_flutter_core/modules/networking/channels/coap/widgets_service.dart';
import 'package:mosaico_flutter_core/toaster.dart';

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
