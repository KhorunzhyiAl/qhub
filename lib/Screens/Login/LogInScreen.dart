import 'dart:math';
import 'package:flutter/material.dart';

import 'package:qhub/Screens/widgets/LineInputField.dart';
import 'package:qhub/Domain/Api/Client/AuthenticationModel.dart';
import 'package:qhub/Domain/Navigation/Routes.dart';

class LogInScreen extends StatelessWidget {
  final _usernameField = LineInputField(
    name: 'Username',
  );
  final _passwordField = LineInputField(
    name: 'Password',
    isPassword: true,
  );

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: theme.backgroundColor,
      body: Container(
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
                  _usernameField,
                  const SizedBox(height: 40),
                  _passwordField,
                  Container(
                    alignment: Alignment.centerLeft,
                    child: TextButton(
                      onPressed: () {},
                      child: const Text('Forgot password'),
                    ),
                  ),
                  const Spacer(),
                  ElevatedButton(
                    onPressed: () async {
                      if (await AuthenticationModel.logInWithPassword(
                        _usernameField.text,
                        _passwordField.text,
                      )) {
                        Navigator.pushNamedAndRemoveUntil(
                            context, Routes.home, (route) => false);
                      }
                    },
                    child: const Text('Log in'),
                  ),
                  const SizedBox(height: 20),
                  OutlinedButton(
                    onPressed: () {
                      Navigator.pushNamedAndRemoveUntil(
                          context, '/sign_up', (_) => false);
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
