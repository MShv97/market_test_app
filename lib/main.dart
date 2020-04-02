import 'package:flutter/material.dart';
import 'start_screen.dart';
import 'checkout.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        // Start the app with the "/" named route. In this case, the app starts
        // on the FirstScreen widget.
        initialRoute: '/',
        routes: {
          // When navigating to the "/" route, build the FirstScreen widget.
          '/': (context) => StartScreen(),
          // When navigating to the "/second" route, build the SecondScreen widget.
          '/checkout': (context) => CheckOut(),
        });
  }
}
