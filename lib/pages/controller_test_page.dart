import 'package:flutter/material.dart';
import 'package:magicsquare/configuration/runners.dart';

import '../networking/tcp_client.dart';
import '../networking/udp_client.dart';

class ControllerTestPage extends StatelessWidget {

  const ControllerTestPage({super.key});
  
  
  void onButtonPressed(String direction) async {
    UdpClient.sendChar(direction);
    print('Button pressed: $direction');
  }

  @override
  Widget build(BuildContext context) {

    // Request matrix to start the game
    TCPClient.startGame(MatrixGameEnum.PIXEL_MOVER);

    return FutureBuilder<void>(
      future: initUdpClient(),
      builder: (context, snapshot) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Controller Test Page'),
          ),
          body: Center(
            child: Column(
              children: [
                ElevatedButton(onPressed: () => onButtonPressed('W'), child: const Text('UP')),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(onPressed: () => onButtonPressed('A'), child: const Text('LEFT')),
                    ElevatedButton(onPressed: () => onButtonPressed('D'), child: const Text('RIGHT')),
                  ],
                ),
                ElevatedButton(onPressed: () => onButtonPressed('S'), child: const Text('DOWN')),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> initUdpClient() async {
    await  UdpClient.initializeClientAsync();
  }
}
