import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qhub/Domain/Api/Enums/SignUpStatus.dart';
import 'package:qhub/Domain/Navigation/Routes.dart';

import 'package:qhub/Domain/Api/Client/SignUpFormModel.dart';
import 'package:qhub/Screens/Widgets/LineInputField.dart';
import 'package:qhub/Domain/Locators/Locator.dart';
import 'package:qhub/Screens/Widgets/ErrorText.dart';


class SignUpScreen extends StatelessWidget {
  final model = locator<SignUpModel>();

  late final _usernameField;
  late final _password1Field;
  late final _password2Field;

  SignUpScreen() {
    _usernameField = LineInputField(
      name: 'Username',
      onChanged: (text) {
        model.username = text;
      },
      onSubmitted: (text) {
        model.username = text;
        model.verifyUsername();
      },
    );

    _password1Field = LineInputField(
      name: 'Password',
      isPassword: true,
      onChanged: (text) {
        model.password1 = text;
      },
    );

    _password2Field = LineInputField(
      name: 'Repeat password',
      isPassword: true,
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
                  StreamProvider<String?>(
                    create: (context) => model.usernameErrorStream,
                    initialData: null,
                    child: Consumer<String?>(
                      builder: (context, message, child) {
                        return ErrorText(message);
                      },
                    ),
                  ),
                  const SizedBox(height: 40),
                  _password1Field,
                  StreamProvider<String?>(
                    create: (context) => model.password1ErrorStream,
                    initialData: null,
                    child: Consumer<String?>(
                      builder: (context, message, child) {
                        return ErrorText(message);
                      },
                    ),
                  ),
                  const SizedBox(height: 40),
                  _password2Field,
                  StreamProvider<String?>(
                    create: (context) => model.password2ErrorStraem,
                    initialData: null,
                    child: Consumer<String?>(
                      builder: (context, message, child) {
                        return ErrorText(message);
                      },
                    ),
                  ),
                  const Spacer(),
                  ValueListenableBuilder<SignUpStatus>(
                    valueListenable: model.status,
                    builder: (context, status, widget) {
                      return ElevatedButton(
                        onPressed: status == SignUpStatus.signUpEnabled
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
