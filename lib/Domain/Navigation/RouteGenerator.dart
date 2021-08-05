import 'package:flutter/material.dart';
import 'package:qhub/Screens/Slpash/SplashScreen.dart';
import 'package:qhub/Screens/login/LogInScreen.dart';
import 'package:qhub/Screens/signup/SignUpScreen.dart';
import 'package:qhub/Screens/error/ErrorScreen.dart';
import 'package:qhub/Domain/Navigation/Routes.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final Widget screen;

    switch (settings.name) {
      case Routes.splash:
        screen = SplashScreen();
        break;
      case Routes.logIn:
        screen = LogInScreen();
        break;
      case Routes.signUp:
        screen =  SignUpScreen();
        break;
      case Routes.home:
        screen = Container();
        break;
      default:
        screen = ErrorScreen(message: "Route '${settings.name}' doesn't exist");
    }

    return MaterialPageRoute(builder: (context) {
      return screen;
    });
  }
}
