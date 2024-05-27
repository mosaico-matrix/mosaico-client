import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:magicsquare/configuration/runners.dart';
import 'package:magicsquare/models/api/widgetable.dart';
import 'package:magicsquare/networking/tcp_client.dart';
import 'package:magicsquare/widgets/matrix_progress_indicator.dart';

import '../../widgets/dialogs/confirmation_dialog.dart';
import '../../widgets/dialogs/toaster.dart';

abstract class WidgetPage<WidgetType> extends StatefulWidget {

  WidgetPage({super.key, required this.widgetType, required this.pageState});


  final MatrixWidgetEnum widgetType;
  int? widgetId;
  WidgetType? widgetModel;
  WidgetPageState<WidgetType> pageState;


  static final logger = Logger(
    printer: PrettyPrinter(),
  );


  @override
  WidgetPageState<WidgetType> createState() => pageState;

  bool isEditMode() {
    return widgetId != null;
  }
  bool isCreateMode() {
    return !isEditMode();
  }

  // Abstract methods to interact with the API
  Future<WidgetType?> createModelApi();
  Future<WidgetType?> updateModelApi();
  Future<WidgetType?> getModelApi();
  WidgetType initNewModel();
}

abstract class WidgetPageState<WidgetType> extends State<WidgetPage> {
  Widget getPageContent(BuildContext context);

  @override
  void dispose() {
    print("Here we should abort the preview");
    super.dispose();
  }

  void onEditClicked();

  void _updateModelAndCallAPI() async {

    try{

      // Call the API to create or update the widget
      Widgetable? updatedWidgetModel = widget.isCreateMode()
          ? await widget.createModelApi()
          : await widget.updateModelApi();

      // Update the state with API state if success
      if (updatedWidgetModel != null) {
        setState(() {
          widget.widgetModel = updatedWidgetModel;
          widget.widgetId = updatedWidgetModel.id;
        });

        // Show success dialog
        Toaster.success("Salvato!");

        // Lose focus on the text field
        FocusScope.of(context).unfocus();

        // Display the widget on the matrix
        TCPClient.displayWidget(widget.widgetType, widget.widgetId!);
      }
    }
    catch(e)
    {
      Toaster.error("Si è verificato un errore :(");
      return;
    }

  }

  _initNewModel() {
    setState(() {
      widget.widgetModel = widget.initNewModel();
    });
  }

  _getModelFromApi() async {
    widget.getModelApi().then((widgetModel) {
      setState(() {
        widget.widgetModel = widgetModel;
      });
    });
  }

  @override
  Widget build(BuildContext context) {

    // Retrieve widgetId from route arguments
    widget.widgetId = ModalRoute.of(context)!.settings.arguments as int?;

    // Create or get the model from the API
    if (widget.widgetModel == null) {
      widget.isCreateMode() ? _initNewModel() : _getModelFromApi();
    }

    return Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.white,
          onPressed: _updateModelAndCallAPI,
          child: const Icon(
              Icons.save,
              color: Colors.black,
          ),
        ),
        appBar: AppBar(
          title: widget.widgetModel == null
              ? const Text("...")
              : Text(widget.widgetModel!.toString()),
          actions: [
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: onEditClicked,
            )
          ],
        ),
        body: widget.widgetModel == null
            ? MatrixProgressIndicator()
            : getPageContent(context));
  }
}
