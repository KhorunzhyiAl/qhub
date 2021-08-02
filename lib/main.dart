import 'package:flutter/material.dart';
import 'package:qhub/RouteGenerator.dart';
import 'package:qhub/Styles/MyTheme.dart';

void main() {
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: myTheme.currentTheme,
      themeMode: myTheme.currentMode,

      initialRoute: '/',
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
