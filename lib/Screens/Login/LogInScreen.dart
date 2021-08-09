import 'dart:math';
import 'package:flutter/material.dart';
import 'package:qhub/Domain/Enums/LogInStatus.dart';
import 'package:qhub/Screens/Widgets/ErrorText.dart';

import 'package:qhub/Screens/widgets/LineInputField.dart';
import 'package:qhub/Domain/Navigation/Routes.dart';
import 'package:qhub/Domain/Models/LogInFormModel.dart';

class LogInScreen extends StatelessWidget {
  final formModel = LogInFormModel();
  late final _usernameField;
  late final _passwordField;

  LogInScreen() {
    _usernameField = LineInputField(
      name: 'Username',
      onChanged: (text) {
        formModel.username = text;
      },
    );
    _passwordField = LineInputField(
      name: 'Password',
      isPassword: true,
      onChanged: (text) {
        formModel.password = text;
      },
    );
  }

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
                  ValueListenableBuilder<String?>(
                    valueListenable: formModel.usernameErrorNotifier,
                    builder: (context, message, child) {
                      return ErrorText(message);
                    },
                  ),
                  const SizedBox(height: 40),
                  _passwordField,
                  ValueListenableBuilder<String?>(
                    valueListenable: formModel.passwordErrorNotifier,
                    builder: (context, message, child) {
                      return ErrorText(message);
                    },
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: TextButton(
                      onPressed: () {},
                      child: const Text('Forgot password'),
                    ),
                  ),
                  const Spacer(),
                  ValueListenableBuilder<LogInStatus>(
                    valueListenable: formModel.status,
                    builder: (_, status, __) {
                      void Function()? onPressed;
                      switch (status) {
                        case LogInStatus.logInDisabled:
                          onPressed = null;
                          break;
                        case LogInStatus.logInEnabled:
                          onPressed = () {
                            formModel.logIn();
                          };
                          break;
                        case LogInStatus.busy:
                          onPressed = null;
                          break;
                      }

                      return ElevatedButton(
                        onPressed: onPressed,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (status == LogInStatus.busy) ...[
                              CircularProgressIndicator(
                                color: Colors.white,
                              ),
                              SizedBox(width: 20),
                            ],
                            const Text('Log in'),
                          ],
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                  OutlinedButton(
                    onPressed: () {
                      Navigator.pushNamedAndRemoveUntil(context, Routes.signUp, (_) => false);
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
