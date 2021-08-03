import 'package:flutter/material.dart';
import 'package:qhub/Domain/Api/Client/AuthenticationModel.dart';
import 'package:qhub/Domain/Navigation/Routes.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    // If the login successfull, open the home screen. If not, open the log in screen.
    AuthenticationModel.logInWithToken().then((value) {
      switch (value) {
        case true:
          Navigator.of(context).pushNamedAndRemoveUntil(Routes.home, (route) => false);
          break;
        case false:
          Navigator.of(context).pushNamedAndRemoveUntil(Routes.logIn, (route) => false);
          break;
      }
    });

    return Scaffold(
      body: Center(
        child: Container(
          color: Colors.transparent,
          width: 150,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                height: 100,
                child: FittedBox(
                  fit: BoxFit.contain,
                  child: Text('qhɥb', style: theme.textTheme.headline1),
                ),
              ),
              LinearProgressIndicator(
                minHeight: 40,
                color: Colors.black,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
