import 'dart:math';
import 'package:flutter/material.dart';

import 'package:qhub/Screens/widgets/LineInputField.dart';
import 'package:qhub/Domain/Api/Client/AuthenticationModel.dart';
import 'package:qhub/Domain/Navigation/Routes.dart';

class _FieldData {
  String username = '';
  String password = '';
}

class LogInScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final screenHeight = MediaQuery.of(context).size.height;
    var fieldData = _FieldData();

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
                  LineInputField(
                    onSubmitted: (text) {
                      fieldData.username = text;
                    },
                  ),
                  const SizedBox(height: 40),
                  Text('Password', style: theme.textTheme.headline6),
                  const SizedBox(height: 5),
                  LineInputField(
                    isPassword: true,
                    onSubmitted: (text) {
                      fieldData.password = text;
                    },
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: TextButton(
                      onPressed: () {},
                      child: const Text('Click here if you forgot password'),
                    ),
                  ),
                  const Spacer(),
                  ElevatedButton(
                    onPressed: () async {
                      if (await AuthenticationModel.logInWithPassword(
                        fieldData.username,
                        fieldData.password,
                      )) {
                        Navigator.pushNamedAndRemoveUntil(context, Routes.home, (route) => false);
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
