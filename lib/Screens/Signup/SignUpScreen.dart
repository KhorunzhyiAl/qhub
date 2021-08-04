import 'dart:math';
import 'package:flutter/material.dart';

import 'package:qhub/Screens/widgets/LineInputField.dart';
import 'package:qhub/Domain/Api/Client/SignUpModel.dart';

class SignUpScreen extends StatelessWidget {
  final _usernameField = LineInputField(
    name: 'Username',
    onSubmitted: (text) {
      SignUpModel.verifySignUpData(username: text);
    },
  );
  final _password1Field = LineInputField(
    name: 'Password',
    isPassword: true,
    onSubmitted: (text) {
      SignUpModel.verifySignUpData(password: text);
    },
  );
  final _password2Field = LineInputField(
    name: 'Repeat password',
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
                  _usernameField,
                  const SizedBox(height: 40),
                  _password1Field,
                  const SizedBox(height: 40),
                  _password2Field,
                  
                  const Spacer(),
                  ElevatedButton(
                    onPressed: () async {
                      await SignUpModel.verifySignUpData(
                        password: _password1Field.text,
                        repeatPassword: _password2Field.text,
                      );

                      if (await SignUpModel.signUp(
                          _usernameField.text, _password1Field.text)) {
                        Navigator.of(context)
                            .pushNamedAndRemoveUntil('/home', (route) => false);
                      }
                    },
                    child: const Text('Sign up'),
                  ),
                  const SizedBox(height: 20),
                  OutlinedButton(
                    onPressed: () {
                      // todo: this doesn't seem like a good solution. Wheather a route must be
                      // placed at the bottom of the stack should be defined somewhere else,
                      // probably
                      Navigator.pushNamedAndRemoveUntil(
                          context, '/log_in', (_) => false);
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
