import 'package:flutter/material.dart';
import 'package:qhub/Screens/IntroLoadingScreen.dart';
import 'package:qhub/Screens/LogInScreen.dart';
import 'package:qhub/MyWidgets/CoolTransitionBuilder.dart';
import 'package:qhub/Screens/SignUpScreen.dart';

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
          return _ErrorPage(message: "Route '${settings.name}' doesn't exist");
        });
    }
  }
}

class _ErrorPage extends StatelessWidget {
  final String message;

  _ErrorPage({required this.message});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return Scaffold(
      body: Container(
          color: Colors.transparent,
          child: Center(
            child: Column(
              children: [
                Text('Error', style: theme.textTheme.headline1),
                Text(message, style: theme.textTheme.caption),
              ],
            ),
          )),
    );
  }
}
