import 'dart:math';

import 'package:flutter/material.dart';
import 'package:qhub/MyWidgets/LineInputField.dart';

class SignUpScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        color: Colors.white,
        child: SingleChildScrollView(
          child: Container(
            height: max(screenHeight, 660),
            alignment: Alignment.center,
            child: Container(
              width: 350,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  const Spacer(),
                  Text('Sign up', style: theme.textTheme.headline1),
                  const SizedBox(height: 40),
                  Text('Username', style: theme.textTheme.headline6),
                  const SizedBox(height: 5),
                  LineInputField(),
                  const SizedBox(height: 40),
                  Text('Password', style: theme.textTheme.headline6),
                  const SizedBox(height: 5),
                  LineInputField(isPassword: true),
                  const SizedBox(height: 40),
                  Text('Repeat password', style: theme.textTheme.headline6),
                  const SizedBox(height: 5),
                  LineInputField(isPassword: true),
                  const Spacer(),
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text('Sign up'),
                  ),
                  const SizedBox(height: 20),
                  OutlinedButton(
                    onPressed: () {
                      // todo: this doesn't seem like a good solution. Wheather a route must be
                      // placed at the bottom of the stack should be defined somewhere else, probably
                      Navigator.pushNamedAndRemoveUntil(context, '/log_in', (_) => false);
                    },
                    child: const Text("Log in"),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
