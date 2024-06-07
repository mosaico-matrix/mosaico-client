import 'package:flutter/material.dart';
import 'package:magicsquare/configuration/routes.dart';
import 'package:magicsquare/models/api/text.dart' as TextModel;
import 'package:magicsquare/services/text_service.dart';
import 'package:magicsquare/widgets/list_cell.dart';
import 'package:magicsquare/widgets/matrix_progress_indicator.dart';

import '../../configuration/runners.dart';


class TextsPage extends StatefulWidget {
  const TextsPage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<TextsPage> {


  List<TextModel.Text>? items;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {

    // Fetch the texts
    var items = await TextService.getTexts();

    setState(() {
      this.items = items;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Testi'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(Routes.text);
            },
          ),
        ],

      ),
      body: items == null
          ?  const Center(child: MatrixProgressIndicator())
          : ListView.builder(
              itemCount: items!.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                  child: ListCell(
                      title: items![index].name,
                      widgetType: MatrixWidgetEnum.TEXT,
                      widgetId: items![index].id,
                      editRoute: Routes.text,
                  ),
                );
              },
            ),
    );
  }
}
