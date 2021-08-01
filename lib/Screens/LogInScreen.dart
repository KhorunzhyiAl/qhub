import 'package:flutter/material.dart';
import 'package:qhub/MyWidgets/LineInputField.dart';

class LogInScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const Spacer(),

              // Label
              Text(
                'Log in',
                style: theme.textTheme.headline1,
              ),

              // Username
              const SizedBox(height: 40),
              Text(
                'Username',
                style: theme.textTheme.headline6,
              ),
              const SizedBox(height: 5),
              LineInputField(
                '',
              ),

              // Password
              const SizedBox(height: 40),
              Text(
                'Password',
                style: theme.textTheme.headline6,
              ),
              const SizedBox(height: 5),
              LineInputField(
                '',
                isPassword: true,
              ),

              // Forgot password
              Container(
                alignment: Alignment.centerLeft,
                child: TextButton(
                  onPressed: () {},
                  child: const Text('Click here if you forgot password'),
                ),
              ),

              const Spacer(),
              // Buttons
              ElevatedButton(
                onPressed: () {},
                child: const Text(
                  'Log in',
                ),
              ),
              const SizedBox(height: 20),
              OutlinedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/sign_up');
                },
                child: const Text(
                  "Create an account",
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
