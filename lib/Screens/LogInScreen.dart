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
              Spacer(),

              // Label
              Text(
                'Log in',
                style: theme.textTheme.headline1,
              ),

              // Username
              SizedBox(height: 40),
              Text(
                'Username',
                style: theme.textTheme.headline6,
              ),
              SizedBox(height: 5),
              LineInputField(
                '',
              ),

              // Password
              SizedBox(height: 40),
              Text(
                'Password',
                style: theme.textTheme.headline6,
              ),
              SizedBox(height: 5),
              LineInputField(
                '',
                isPassword: true,
              ),

              // Forgot password
              Container(
                alignment: Alignment.centerLeft,
                child: TextButton(
                  onPressed: () {},
                  child: Text('Click here if you forgot password'),
                ),
              ),

              Spacer(),
              // Buttons
              ElevatedButton(
                onPressed: () {},
                child: Text(
                  'Log in',
                ),
              ),
              SizedBox(height: 20),
              OutlinedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/sign_up');
                },
                child: Text(
                  "Create an account",
                ),
              ),
              SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
