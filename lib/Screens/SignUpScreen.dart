import 'package:flutter/material.dart';
import 'package:qhub/MyWidgets/LineInputField.dart';

class SignUpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        color: Colors.white,
        child: SingleChildScrollView(
          child: Container(
            height: screenHeight,
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Spacer(),
        
                // Label
                Text(
                  'Sign up',
                  style: theme.textTheme.headline1,
                ),
        
                // Fields
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
                // Repeat password
                SizedBox(height: 40),
                Text(
                  'Repeat password',
                  style: theme.textTheme.headline6,
                ),
                SizedBox(height: 5),
                LineInputField(
                  '',
                  isPassword: true,
                ),
        
                Spacer(),
                // Buttons
                ElevatedButton(
                  onPressed: () {},
                  child: Text(
                    'Sign up',
                  ),
                ),
                SizedBox(height: 20),
                OutlinedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/log_in');
                  },
                  child: Text(
                    "Log in",
                  ),
                ),
                SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
