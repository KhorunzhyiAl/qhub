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
                const Spacer(),
        
                // Label
                Text(
                  'Sign up',
                  style: theme.textTheme.headline1,
                ),
        
                // Fields
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
                // Repeat password
                const SizedBox(height: 40),
                Text(
                  'Repeat password',
                  style: theme.textTheme.headline6,
                ),
                const SizedBox(height: 5),
                LineInputField(
                  '',
                  isPassword: true,
                ),
        
                const Spacer(),
                // Buttons
                ElevatedButton(
                  onPressed: () {},
                  child: const Text(
                    'Sign up',
                  ),
                ),
                const SizedBox(height: 20),
                OutlinedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/log_in');
                  },
                  child: const Text(
                    "Log in",
                  ),
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
