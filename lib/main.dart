import 'dart:io';

import 'package:flutter/material.dart';
import 'package:qhub/Domain/Core/FlashbarController.dart';
import 'package:qhub/Domain/Navigation/RouteGenerator.dart';
import 'package:qhub/Config/MyTheme.dart';
import 'package:qhub/Domain/Navigation/Routes.dart';
import 'package:qhub/Domain/Locators.dart';
import 'package:qhub/Screens/Widgets/Flashbar/Flashbar.dart';

void main() async {
  initLocator();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = MyTheme();

    return MaterialApp(
      theme: theme.currentTheme,
      themeMode: theme.currentMode,
      initialRoute: Routes.splash,
      onGenerateRoute: RouteGenerator.generateRoute,
      builder: (context, child) {
        if (child == null) return SizedBox.shrink();

        return Stack(
          children: [
            child,
            Flashbar(locator<FlashbarController>()),
          ],
        );
      },
    );
  }
}
