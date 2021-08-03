import 'package:flutter/material.dart';
import 'package:qhub/Screens/Slpash/IntroLoadingScreen.dart';
import 'package:qhub/Screens/login/LogInScreen.dart';
import 'package:qhub/Screens/widgets/CoolTransitionBuilder.dart';
import 'package:qhub/Screens/signup/SignUpScreen.dart';
import 'package:qhub/Screens/error/ErrorScreen.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (context) {
          return IntroLoadingScreen();
        });
      case '/log_in':
        return MaterialPageRoute(builder: (context) {
          return CoolTransitionBuilder(child: LogInScreen());
        });
      case '/sign_up':
        return MaterialPageRoute(builder: (context) {
          return CoolTransitionBuilder(child: SignUpScreen());
        });
      default:
        return MaterialPageRoute(builder: (context) {
          return ErrorScreen(message: "Route '${settings.name}' doesn't exist");
        });
    }
  }
}


