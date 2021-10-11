import 'package:flutter/material.dart';

class ErrorScreen extends StatelessWidget {
  final String message;

  ErrorScreen({required this.message});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return Scaffold(
      body: Container(
        color: theme.colorScheme.background,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Error', style: theme.textTheme.headline1),
              Text(message, style: theme.textTheme.caption),
            ],
          ),
        ),
      ),
    );
  }
}
