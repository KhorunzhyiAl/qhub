import 'package:flutter/material.dart';
import 'package:qhub/Screens/widgets/Flipper.dart';

class LineInputField extends StatefulWidget {
  final bool isPassword;
  final void Function(String)? onSubmitted;

  LineInputField({
    this.isPassword = false,
    this.onSubmitted,
  });

  @override
  _LineInputFieldState createState() => _LineInputFieldState();
}



class _LineInputFieldState extends State<LineInputField> {
  bool _obscureText = false;

  IconButton _hideButton() {
    return IconButton(
      key: UniqueKey(),
      onPressed: () {
        setState(() {
          _obscureText = !_obscureText;
        });
      },
      padding: const EdgeInsets.symmetric(horizontal: 20),
      icon: Icon(_obscureText ? Icons.visibility_off : Icons.visibility),
    );
  }

  TextField _textField() {
    var theme = Theme.of(context);
    return TextField(
      style: theme.textTheme.bodyText1,
      obscureText: _obscureText,
      onSubmitted: widget.onSubmitted,
      decoration: InputDecoration(
        filled: true,
        // TODO: use a theme color
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
  void initState() {
    super.initState();
    _obscureText = widget.isPassword;
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
