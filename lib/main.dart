import 'package:flutter/material.dart';
import 'package:qhub/Screens/LogInScreen.dart';

void main() {
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: <String, Widget Function(BuildContext)>{
        '/log_in': (context) {
          return LogInScreen();
        },
      },

      home: LogInScreen(),
    );
  }
}
