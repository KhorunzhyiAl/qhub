import 'package:flutter/material.dart';
import 'package:qhub/Domain/Navigation/RouteGenerator.dart';
import 'package:qhub/Config/MyTheme.dart';
import 'package:qhub/Domain/Locators/Locator.dart';
import 'package:qhub/Domain/Navigation/Routes.dart';
import 'package:qhub/Domain/Service.dart';
import 'package:qhub/Domain/Enums/ClientStatus.dart';

late final Service _service;
late final Future<bool> _loggedIn;
String _initialRoute = Routes.splash;

void main() {
  initLocator();
  _service = locator<Service>();
  _loggedIn = _service.logInWithToken();
  _loggedIn.then((value) {
    print('future finished. value = $value');
    _initialRoute = value ? Routes.home : Routes.logIn;
  });

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final navKey = GlobalKey<NavigatorState>();

    _service.addStatusListener((status) {
      print('status changed. status = $status');
      switch (status) {
        case ClientStatus.loggedIn:
          navKey.currentState?.pushNamedAndRemoveUntil(Routes.home, (route) => false);
          break;
        case ClientStatus.loggedOut:
          navKey.currentState?.pushNamedAndRemoveUntil(Routes.logIn, (route) => false);
          break;
        case ClientStatus.starting:
          break;
      }
    });

    print('initial route = $_initialRoute');
    return MaterialApp(
      theme: myTheme.currentTheme,
      themeMode: myTheme.currentMode,
      initialRoute: _initialRoute,
      navigatorKey: navKey,
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
