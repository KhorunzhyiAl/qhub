import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
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
