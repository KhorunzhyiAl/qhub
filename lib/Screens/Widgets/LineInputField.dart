import 'package:flutter/material.dart';
import 'package:qhub/Screens/widgets/Flipper.dart';

class _FieldData {
  var text = '';
  var obscureText = false;
}

class LineInputField extends StatefulWidget {
  final String name;
  final bool isPassword;
  final void Function(String)? onChanged;
  final void Function(String)? onSubmitted;
  final fieldData = _FieldData();

  String get text => fieldData.text;

  LineInputField({
    required this.name,
    this.isPassword = false,
    this.onChanged,
    this.onSubmitted,
  }) {
    fieldData.obscureText = isPassword;
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
          widget.fieldData.obscureText = !widget.fieldData.obscureText;
        });
      },
      padding: const EdgeInsets.symmetric(horizontal: 20),
      icon: Icon(widget.fieldData.obscureText ? Icons.visibility_off : Icons.visibility),
    );
  }

  TextField _textField() {
    var theme = Theme.of(context);
    return TextField(
      autofocus: true,
      style: theme.textTheme.bodyText1,
      obscureText: widget.fieldData.obscureText,
      onChanged: widget.onChanged,
      onSubmitted: widget.onSubmitted,
      decoration: InputDecoration(
        filled: true,
        fillColor: theme.canvasColor,
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
    var theme = Theme.of(context);
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.name, style: theme.textTheme.headline6),
          const SizedBox(height: 5),
          Stack(
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
          ),
        ],
      ),
    );
  }
}
