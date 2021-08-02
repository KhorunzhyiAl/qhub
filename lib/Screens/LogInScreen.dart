import 'dart:math';

import 'package:flutter/material.dart';
import 'package:qhub/MyWidgets/LineInputField.dart';

class LogInScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        color: Colors.white,
        child: SingleChildScrollView(
          child: Container(
            height: max(screenHeight, 600),
            alignment: Alignment.center,
            child: Container(
              width: 350,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  const Spacer(),
                  Text('Log in', style: theme.textTheme.headline1),
                  const SizedBox(height: 40),
                  Text('Username', style: theme.textTheme.headline6),
                  const SizedBox(height: 5),
                  LineInputField(),
                  const SizedBox(height: 40),
                  Text('Password', style: theme.textTheme.headline6),
                  const SizedBox(height: 5),
                  LineInputField(isPassword: true),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: TextButton(
                      onPressed: () {},
                      child: const Text('Click here if you forgot password'),
                    ),
                  ),
                  const Spacer(),
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text('Log in'),
                  ),
                  const SizedBox(height: 20),
                  OutlinedButton(
                    onPressed: () {
                      Navigator.pushNamedAndRemoveUntil(context, '/sign_up', (_) => false);
                    },
                    child: const Text("Create an account"),
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
