import 'dart:math';
import 'package:flutter/material.dart';
import 'package:qhub/Domain/Enums/SignUpStatus.dart';
import 'package:qhub/Domain/Navigation/Routes.dart';

import 'package:qhub/Domain/Models/SignUpFormModel.dart';
import 'package:qhub/Screens/Widgets/LineInputField.dart';
import 'package:qhub/Screens/Widgets/ErrorText.dart';

class SignUpScreen extends StatelessWidget {
  final model = SignUpFormModel();

  late final _usernameField;
  late final _password1Field;
  late final _password2Field;

  SignUpScreen() {
    _usernameField = LineInputField(
      name: 'Username',
      onChanged: (text) {
        model.username = text;
      },
    );

    _password1Field = LineInputField(
      name: 'Password',
      obstructText: true,
      onChanged: (text) {
        model.password1 = text;
      },
    );

    _password2Field = LineInputField(
      name: 'Repeat password',
      obstructText: true,
      onChanged: (text) {
        model.password2 = text;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: theme.colorScheme.background,
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
                  ValueListenableBuilder<String?>(
                    valueListenable: model.usernameErrorNotifier,
                    builder: (_, message, __) {
                      return ErrorText(message);
                    },
                  ),
                  const SizedBox(height: 40),
                  _password1Field,
                  ValueListenableBuilder<String?>(
                    valueListenable: model.password1ErrorNotifier,
                    builder: (_, message, __) {
                      return ErrorText(message);
                    },
                  ),
                  const SizedBox(height: 40),
                  _password2Field,
                  ValueListenableBuilder<String?>(
                    valueListenable: model.password2ErrorNotifier,
                    builder: (_, message, __) {
                      return ErrorText(message);
                    },
                  ),
                  const Spacer(),
                  ValueListenableBuilder<SignUpStatus>(
                    valueListenable: model.status,
                    builder: (context, status, widget) {
                      void Function()? onPressed;
                      switch (status) {
                        case SignUpStatus.signUpEnabled:
                          onPressed = () {
                            model.signUp();
                          };
                          break;
                        case SignUpStatus.signUpDisabled:
                          onPressed = null;
                          break;
                        case SignUpStatus.busy:
                          onPressed = null;
                          break;
                      }

                      return ElevatedButton(
                        onPressed: onPressed,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (status == SignUpStatus.busy) ...[
                              CircularProgressIndicator(
                                color: Colors.white,
                              ),
                              SizedBox(width: 20),
                            ],
                            const Text('Sign up'),
                          ],
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                  OutlinedButton(
                    onPressed: () {
                      Navigator.pushNamedAndRemoveUntil(context, Routes.logIn, (_) => false);
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
