import 'package:flutter/material.dart';
import 'package:qhub/Domain/Navigation/RouteGenerator.dart';
import 'package:qhub/Config/MyTheme.dart';
import 'package:qhub/Domain/Locators/Locator.dart';
import 'package:qhub/Domain/Navigation/Routes.dart';
import 'package:qhub/Domain/Api/Client/ClientModel.dart';
import 'package:qhub/Domain/Api/Enums/ClientStatus.dart';

void main() {
  initLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final navKey = GlobalKey<NavigatorState>();
    final clientModel = locator<ClientModel>();

    clientModel.addStatusListener((status) {
      switch (status) {
        case ClientStatus.loggedIn:
          navKey.currentState?.pushNamedAndRemoveUntil(Routes.home, (route) => false);
          break;
        case ClientStatus.loggedOut:
          navKey.currentState?.pushNamedAndRemoveUntil(Routes.logIn, (route) => false);
          break;
        case ClientStatus.trying:
          navKey.currentState?.pushNamedAndRemoveUntil(Routes.splash, (route) => false);
          break;
      }
    });

    return MaterialApp(
      theme: myTheme.currentTheme,
      themeMode: myTheme.currentMode,
      initialRoute: Routes.splash,
      navigatorKey: navKey,
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
