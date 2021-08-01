import 'package:flutter/material.dart';
import 'package:qhub/MyWidgets/CoolTransitionBuilder.dart';
import 'package:qhub/Screens/LogInScreen.dart';
import 'package:qhub/Screens/SignUpScreen.dart';
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

      routes: <String, Widget Function(BuildContext)>{
        '/log_in': (context) {
          return CoolTransitionBuilder(child: LogInScreen());
        },
        '/sign_up': (context) {
          return CoolTransitionBuilder(child: SignUpScreen());
        },
        '/': (context) {
          // Todo: there shoudl be a different screen.
          return LogInScreen();
        }
      },
    );
  }
}
