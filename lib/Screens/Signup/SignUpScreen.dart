import 'dart:math';
import 'package:flutter/material.dart';
import 'package:qhub/Domain/Api/Enums.dart';

import 'package:qhub/Screens/widgets/LineInputField.dart';
import 'package:qhub/Domain/Api/Client/SignUpModel.dart';
import 'package:qhub/Domain/Locators/Locator.dart';

class _ErrorMessage extends StatelessWidget {
  final String? error;

  _ErrorMessage(this.error);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      height: error != null ? 25 : 0,
      curve: Curves.easeOutSine,
      alignment: Alignment.centerLeft,
      child: error != null
          ? Text(
              error!,
              style: theme.textTheme.caption?.copyWith(color: theme.errorColor),
            )
          : null,
    );
  }
}

class SignUpScreen extends StatelessWidget {
  final _usernameField = LineInputField(
    name: 'Username',
    onChanged: (text) {
      var model = locator<SignUpModel>();
      model.username = text;
    },
  );
  final _password1Field = LineInputField(
    name: 'Password',
    isPassword: true,
    onChanged: (text) {
      var model = locator<SignUpModel>();
      model.password1 = text;
    },
  );
  final _password2Field = LineInputField(
    name: 'Repeat password',
    isPassword: true,
    onChanged: (text) {
      var model = locator<SignUpModel>();
      model.password2 = text;
    },
  );

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final screenHeight = MediaQuery.of(context).size.height;
    final model = locator<SignUpModel>();

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
                  ValueListenableBuilder<List<String>>(
                    valueListenable: model.usernameErrorNotifier,
                    builder: (context, errors, _) {
                      return _ErrorMessage(errors.length > 0 ? errors[0] : null);
                    },
                  ),
                  const SizedBox(height: 40),
                  _password1Field,
                  ValueListenableBuilder<String?>(
                    valueListenable: model.password1ErrorNotifier,
                    builder: (context, error, _) {
                      return _ErrorMessage(error);
                    },
                  ),
                  const SizedBox(height: 40),
                  _password2Field,
                  ValueListenableBuilder<String?>(
                    valueListenable: model.password2ErrorNotifier,
                    builder: (context, error, _) {
                      return _ErrorMessage(error);
                    },
                  ),
                  const Spacer(),
                  ValueListenableBuilder<SignUpStatus>(
                    valueListenable: model.status,
                    builder: (context, status, widget) {
                      return ElevatedButton(
                        onPressed: status == SignUpStatus.correct
                            ? () async {
                                if (await model.signUp()) {
                                  Navigator.of(context)
                                      .pushNamedAndRemoveUntil('/home', (route) => false);
                                }
                              }
                            : null,
                        child: const Text('Sign up'),
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                  OutlinedButton(
                    onPressed: () {
                      // todo: this doesn't seem like a good solution. Wheather a route must be
                      // placed at the bottom of the stack should be defined somewhere else,
                      // probably
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
