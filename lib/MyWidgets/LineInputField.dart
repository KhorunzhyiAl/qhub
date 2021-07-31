import 'dart:math';

import 'package:flutter/material.dart';
import 'package:qhub/MyWidgets/Flipper.dart';
import 'package:qhub/Styles/TextStyles.dart' as textStyles;

class LineInputField extends StatefulWidget {
  final String placeholder;
  final bool isPassword;
  bool _obscureText = false;

  LineInputField(this.placeholder, {this.isPassword = false}) {
    if (isPassword) _obscureText = true;
  }

  @override
  _LineInputFieldState createState() => _LineInputFieldState();
}

class _LineInputFieldState extends State<LineInputField> {
  IconButton _hideButton() {
    return IconButton(
      key: UniqueKey(),
      onPressed: () {
        setState(() {
          widget._obscureText = !widget._obscureText;
        });
      },
      padding: EdgeInsets.symmetric(horizontal: 20),
      icon: Icon(widget._obscureText ? Icons.visibility_off : Icons.visibility),
    );
  }

  TextField _textField() {
    return TextField(
      style: textStyles.bodyStyle,
      obscureText: widget._obscureText,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.grey.shade200,
        hintText: widget.placeholder,
        hintStyle: TextStyle(
          color: Colors.grey.shade500,
          fontSize: textStyles.bodyStyle.fontSize,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(
            width: 0,
            style: BorderStyle.none,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.centerRight,
      children: <Widget>[
        _textField(),
        if (widget.isPassword)
          Flipper(
            child: _hideButton(),
            flipDuration: Duration(milliseconds: 200),
            curve: Curves.easeInOutSine,
            axis: FlipAxis.X,
          ),
      ],
    );
  }
}
