import 'dart:math';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:qhub/Domain/Navigation/Routes.dart';

import 'package:qhub/Domain/Auth/SignUpFormModel.dart';
import 'package:qhub/Screens/Widgets/LineInputField.dart';
import 'package:qhub/Screens/Widgets/ErrorText.dart';

class SignUpScreen extends StatelessWidget {
  final model = SignUpFormModel();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
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
                  LineInputField(
                    name: 'Username',
                    onChanged: (text) {
                      model.username = text;
                      model.verifyFields();
                    },
                  ),
                  ValueListenableBuilder<Option<String>>(
                    valueListenable: model.usernameErrorNotifier,
                    builder: (_, message, __) {
                      return message.fold(
                        () => ErrorText(null),
                        (a) => ErrorText(model.touchedUsername ? a : null),
                      );
                    },
                  ),
                  const SizedBox(height: 40),
                  LineInputField(
                    name: 'Password',
                    obstructText: true,
                    onChanged: (text) {
                      model.password1 = text;
                      model.verifyFields();
                    },
                  ),
                  ValueListenableBuilder<Option<String>>(
                    valueListenable: model.password1ErrorNotifier,
                    builder: (_, message, __) {
                      return message.fold(
                        () => ErrorText(null),
                        (a) => ErrorText(model.touchedPassword1 ? a : null),
                      );
                    },
                  ),
                  const SizedBox(height: 40),
                  LineInputField(
                    name: 'Repeat password',
                    obstructText: true,
                    onChanged: (text) {
                      model.password2 = text;
                      model.verifyFields();
                    },
                  ),
                  ValueListenableBuilder<Option<String>>(
                    valueListenable: model.password2ErrorNotifier,
                    builder: (_, message, __) {
                      return message.fold(
                        () => ErrorText(null),
                        (a) => ErrorText(model.touchedPassword2 ? a : null),
                      );
                    },
                  ),
                  const Spacer(),
                  ValueListenableBuilder<SignUpStatus>(
                    valueListenable: model.status,
                    builder: (context, status, widget) {
                      void Function()? onPressed;
                      switch (status) {
                        case SignUpStatus.enabled:
                          onPressed = () {
                            model.signUp();
                          };
                          break;
                        case SignUpStatus.disabled:
                          onPressed = null;
                          break;
                        case SignUpStatus.busy:
                          onPressed = null;
                          break;
                      }

                      return SizedBox(
                        height: 60,
                        child: ElevatedButton(
                          onPressed: onPressed,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              if (status == SignUpStatus.busy) ...[
                                AspectRatio(
                                  aspectRatio: 1,
                                  child: CircularProgressIndicator(),
                                ),
                              ] else ...[
                                const Text('Sign up'),
                              ],
                            ],
                          ),
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
