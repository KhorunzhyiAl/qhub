import 'package:flutter/material.dart';
import 'package:qhub/MyWidgets/LineInputField.dart';
import 'package:qhub/Styles/TextStyles.dart' as textStyles;

class LogInScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
                style: textStyles.heading1Style,
              ),

              // Fields
              // Username
              SizedBox(height: 40),
              Text(
                'Username',
                style: textStyles.captionStyle,
              ),
              SizedBox(height: 5),
              LineInputField(
                '',
              ),

              // Password
              SizedBox(height: 40),
              Text(
                'Password',
                style: textStyles.captionStyle,
              ),
              SizedBox(height: 5),
              LineInputField(
                '',
                isPassword: true,
              ),
              TextButton(
                onPressed: () {},
                style: ButtonStyle(
                  alignment: Alignment.centerLeft,
                  animationDuration: Duration(milliseconds: 100),
                  foregroundColor:
                      MaterialStateProperty.resolveWith((states) {
                        if (states.contains(MaterialState.pressed)) {
                          return Colors.blue;
                        }
                        return Colors.black;
                      }),
                  overlayColor:
                      MaterialStateProperty.all<Color?>(Colors.transparent),
                ),
                child: Text(
                  'Forgot password?',
                  style: textStyles.hintStyle,
                ),
              ),

              Spacer(),
              // Buttons
              ElevatedButton(
                onPressed: () {},
                style: ButtonStyle(
                  elevation: MaterialStateProperty.all<double>(10),
                  backgroundColor:
                      MaterialStateProperty.all<Color?>(Colors.black),
                  padding: MaterialStateProperty.all<EdgeInsets?>(
                      EdgeInsets.all(10)),
                ),
                child: Text(
                  'Log in',
                  style: textStyles.heading1Style,
                ),
              ),
              SizedBox(height: 20),
              TextButton(
                onPressed: () {},
                style: ButtonStyle(
                  foregroundColor:
                      MaterialStateProperty.all<Color?>(Colors.black),
                  overlayColor:
                      MaterialStateProperty.all<Color?>(Colors.black12),
                ),
                child: Text(
                  "Don't have an account?",
                  style: textStyles.captionStyle,
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
