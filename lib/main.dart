import 'package:flutter/material.dart';
import 'package:qhub/MyWidgets/CoolTransitionBuilder.dart';
import 'package:qhub/Screens/LogInScreen.dart';
import 'package:qhub/Screens/SignUpScreen.dart';

void main() {
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      routes: <String, Widget Function(BuildContext)>{
        '/log_in': (context) {
          return CoolTransitionBuilder(child: LogInScreen());
        },
        '/sign_up': (context) {
          return CoolTransitionBuilder(child: SignUpScreen());
        },
      },
      home: LogInScreen(),
    );
  }
}
