import 'package:flutter/material.dart';
import 'package:mosaico/features/store/presentation/pages/store_page.dart';
import 'package:mosaico_flutter_core/features/mosaico_loading/presentation/states/mosaico_loading_state.dart';
import 'package:provider/provider.dart';
import '../../../../core/configuration/routes.dart';
import '../widgets/dashboard_button.dart';


class Home extends StatelessWidget {

  // Home configuration
  static const double widgetSpacing = 40.0;
  static const double horizontalPadding = 10.0;

  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return Scaffold(
          body: Center(
            child: Column(
              children: [

                // Header notch with device status
                //const DeviceStatusNotch(),

                // Spacer
                const Spacer(),

                ElevatedButton(
                    onPressed: () async {
                      Navigator.pushNamed(context, Routes.debug);
                    },
                    child: const Text("Debug")),


                // Main widgets
                const Padding(
                  padding: EdgeInsets.all(horizontalPadding),
                  child: Column(
                    children: [
                      Row(
                        // Enlarge children to fill the space
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: DashboardButton(
                                title: "Widgets",
                                startColor: Colors.red,
                                route: Routes.widgets,
                                endColor: Colors.blue),
                          ),
                          SizedBox(width: horizontalPadding),
                          Expanded(
                            child: DashboardButton(
                                title: "Games",
                                route: '',
                                startColor: Colors.green,
                                endColor: Colors.yellow),
                          ),
                        ],
                      ),
                      SizedBox(height: widgetSpacing),
                      Row(
                        children: [
                          Expanded(
                              child: DashboardButton(
                                  title: "Slideshows",
                                  route: '',
                                  startColor: Colors.purple,
                                  endColor: Colors.orange)),
                        ],
                      ),
                      SizedBox(height: widgetSpacing),
                      Row(
                        children: [
                          Expanded(
                              child: DashboardButton(
                                  title: "Store",
                                  route: Routes.store,
                                  startColor: Colors.blue,
                                  endColor: Colors.red)),
                        ],
                      ),
                    ],
                  ),
                ),
                const Spacer(),

                // Modal alert hidden by default
              ],
            ),
          ),
        );
      }
    );
  }
}

