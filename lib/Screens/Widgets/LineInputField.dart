import 'package:flutter/material.dart';
import 'package:qhub/Screens/widgets/Flipper.dart';

class LineInputField extends StatefulWidget {
  final bool isPassword;
  bool _obscureText = false;

  LineInputField({this.isPassword = false}) {
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
      padding: const EdgeInsets.symmetric(horizontal: 20),
      icon: Icon(widget._obscureText ? Icons.visibility_off : Icons.visibility),
    );
  }

  TextField _textField() {
    var theme = Theme.of(context);
    return TextField(
      style: theme.textTheme.bodyText1,
      obscureText: widget._obscureText,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.grey.shade200,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(
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
            flipDuration: const Duration(milliseconds: 200),
            curve: Curves.easeInOutSine,
            axis: FlipAxis.X,
          ),
      ],
    );
  }
}
