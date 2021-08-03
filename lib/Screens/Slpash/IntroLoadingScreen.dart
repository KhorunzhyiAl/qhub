import 'package:flutter/material.dart';

class IntroLoadingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
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
