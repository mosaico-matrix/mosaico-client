import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:magicsquare/networking/ble_connection_manager.dart';
import 'package:magicsquare/widgets/led_matrix.dart';

class SafeAreaWithWhiteBackground extends StatelessWidget {
  final Widget child;

  const SafeAreaWithWhiteBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(40),
          bottomRight: Radius.circular(40),
        ),
      ),
      child: SafeArea(
        bottom: false,
        maintainBottomViewPadding: true,
        child: child,
      ),
    );
  }
}

class DeviceStatusNotch extends StatefulWidget {
  const DeviceStatusNotch({super.key});

  @override
  State<DeviceStatusNotch> createState() => _DeviceStatusNotchState();
}

class _DeviceStatusNotchState extends State<DeviceStatusNotch> {
  bool isConnected = false;
  bool isSearching = false;

  void checkDeviceStatus() async {
    setState(() {
      isConnected = false;
      isSearching = true;
    });

    // Try to connect to the matrix
    await BLEConnectionManager.searchAndConnectMatrix();

    // Check if matrix is connected
    setState(() {
      isConnected = BLEConnectionManager.matrixConnected();
      isSearching = false;
    });

    // Listen to matrix changes and update the UI accordingly
    if (BLEConnectionManager.matrixConnected()) {
      var subscription = BLEConnectionManager.getConnectedMatrix().onServicesReset
          .listen((_) async {
        await BLEConnectionManager.getConnectedMatrix().disconnect();
        checkDeviceStatus();
      });
      BLEConnectionManager.getConnectedMatrix().cancelWhenDisconnected(subscription);
    }
  }

  @override
  void initState() {
    super.initState();
    checkDeviceStatus();
  }

  @override
  Widget build(BuildContext context) {
    final statusText = isSearching
        ? 'Searching'
        : isConnected
            ? 'Connected'
            : 'Offline';

    return SafeAreaWithWhiteBackground(
      child: Padding(
        padding: const EdgeInsets.only(top: 15, bottom: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const LedMatrix(),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // Title
                Text(
                  statusText,
                  style: const TextStyle(
                    fontSize: 40,
                    height: 0,
                  ),
                ),
                // Retry button
                TextButton(
                  style: ButtonStyle(
                    textStyle: MaterialStateProperty.all<TextStyle>(
                      const TextStyle(
                        decoration: TextDecoration.underline,
                      ),
                    ),
                    padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                        EdgeInsets.zero),
                    minimumSize: MaterialStateProperty.all<Size>(Size.zero),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.blue),
                  ),
                  onPressed: isSearching
                      ? null
                      : () {
                          checkDeviceStatus();
                        },
                  child: Visibility(
                    visible: !isConnected && !isSearching,
                      child: const Text('Retry')
                  ),
                ),
              ],
            ),
            Lottie.asset(
              isConnected
                  ? 'assets/lottie/green-pulse.json'
                  : 'assets/lottie/red-pulse.json',
              width: 70,
              fit: BoxFit.contain,
              height: 70,
            ),
          ],
        ),
      ),
    );
  }
}
