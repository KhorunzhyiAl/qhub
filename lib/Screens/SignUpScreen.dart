import 'package:flutter/material.dart';
import 'package:qhub/Styles/TextStyles.dart' as ts;
import 'package:qhub/MyWidgets/LineInputField.dart';

class SignUpScreen extends StatelessWidget {
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
                'Sign up',
                style: ts.heading1Style,
              ),

              // Fields
              // Username
              SizedBox(height: 40),
              Text(
                'Username',
                style: ts.captionStyle,
              ),
              SizedBox(height: 5),
              LineInputField(
                '',
              ),

              // Password
              SizedBox(height: 40),
              Text(
                'Password',
                style: ts.captionStyle,
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
                style: ts.captionStyle,
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
                style: ButtonStyle(
                  elevation: MaterialStateProperty.all<double>(10),
                  backgroundColor:
                      MaterialStateProperty.all<Color?>(Colors.black),
                  padding: MaterialStateProperty.all<EdgeInsets?>(
                      EdgeInsets.all(10)),
                ),
                child: Text(
                  'Sign up',
                  style: ts.heading1Style,
                ),
              ),
              SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/log_in');
                },
                style: ButtonStyle(
                  foregroundColor:
                      MaterialStateProperty.all<Color?>(Colors.black),
                  overlayColor:
                      MaterialStateProperty.all<Color?>(Colors.black12),
                ),
                child: Text(
                  "Log in",
                  style: ts.captionStyle,
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
