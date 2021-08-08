import 'package:flutter/material.dart';
import 'package:qhub/Domain/Services/ClientService.dart';
import 'package:qhub/Domain/Locators/Locator.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final clientModel = locator<ClientService>();

    clientModel.logInWithToken();

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
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
                backgroundColor: Colors.transparent
              ),
            ],
          ),
        ),
      ),
    );
  }
}
