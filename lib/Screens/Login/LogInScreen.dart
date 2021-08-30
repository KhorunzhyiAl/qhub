import 'dart:math';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:qhub/Screens/Widgets/ErrorText.dart';

import 'package:qhub/Screens/widgets/LineInputField.dart';
import 'package:qhub/Domain/Navigation/Routes.dart';
import 'package:qhub/Domain/Auth/LogInFormModel.dart';

class LogInScreen extends StatelessWidget {
  final formModel = LogInFormModel();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
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
                  // _usernameField,
                  LineInputField(
                    name: 'Username',
                    onChanged: (text) {
                      formModel.username = text;
                      formModel.validateFields();
                    },
                  ),
                  ValueListenableBuilder<Option<String>>(
                    valueListenable: formModel.usernameErrorNotifier,
                    builder: (context, error, child) {
                      return error.fold(
                        () => ErrorText(null),
                        (a) => ErrorText(formModel.touchedUsername ? a : null),
                      );
                    },
                  ),
                  const SizedBox(height: 40),
                  // _passwordField,
                  LineInputField(
                    name: 'Password',
                    obstructText: true,
                    eyeButton: true,
                    onChanged: (text) {
                      formModel.password = text;
                      formModel.validateFields();
                    },
                  ),
                  ValueListenableBuilder<Option<String>>(
                    valueListenable: formModel.passwordErrorNotifier,
                    builder: (context, error, child) {
                      return error.fold(
                        () => ErrorText(null),
                        (a) => ErrorText(formModel.touchedPassword ? a : null),
                      );
                    },
                  ),
                  ValueListenableBuilder<Option<String>>(
                    valueListenable: formModel.logInErrorNotifier,
                    builder: (context, error, child) {
                      return error.fold(
                        () => ErrorText(null),
                        (a) => ErrorText(a),
                      );
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
                        case LogInStatus.disabled:
                          onPressed = null;
                          break;
                        case LogInStatus.enabled:
                          onPressed = () {
                            formModel.logIn();
                          };
                          break;
                        case LogInStatus.loading:
                          onPressed = null;
                          break;
                      }

                      return ElevatedButton(
                        onPressed: onPressed,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (status == LogInStatus.loading) ...[
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
