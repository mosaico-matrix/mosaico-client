import 'package:flutter/material.dart';

class CarouselMenuItem
{
  final String title;
  final String description;
  final String route;

  const CarouselMenuItem({required this.title, required this.description, required this.route});

  Widget buildWidget(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.8,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 40),
        child: Column(
          children: <Widget>[
            Text(title, style: const TextStyle(fontSize: 24, color: Colors.white), textAlign: TextAlign.center),
            Text(description, style: const TextStyle(fontSize: 16, color: Colors.white), textAlign: TextAlign.center),
            ButtonBar(
              alignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(Colors.white),
                  ),
                  onPressed: () => Navigator.of(context).pushNamed(route),
                  child: const Text('Open', style: TextStyle(color: Colors.black)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}