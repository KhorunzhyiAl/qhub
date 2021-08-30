import 'package:flutter/material.dart';
import 'package:qhub/Screens/widgets/Flipper.dart';

class LineInputField extends StatefulWidget {
  final String name;
  final bool obstructText;
  final bool eyeButton;
  final void Function(String)? onChanged;
  final void Function(String)? onSubmitted;

  LineInputField({
    required this.name,
    this.obstructText = false,
    this.eyeButton = false,
    this.onChanged,
    this.onSubmitted,
  });

  @override
  _LineInputFieldState createState() => _LineInputFieldState();
}

class _LineInputFieldState extends State<LineInputField> {
  bool obstructText = false;
  late final Key _visibilityOffKey;
  late final Key _visibliityKey;

  IconButton _hideButton() {
    return IconButton(
      key: obstructText ? _visibilityOffKey : _visibliityKey,
      onPressed: () {
        setState(() {
          obstructText = !obstructText;
        });
      },
      padding: const EdgeInsets.symmetric(horizontal: 20),
      icon: Icon(obstructText ? Icons.visibility_off : Icons.visibility),
    );
  }

  TextField _textField() {
    var theme = Theme.of(context);
    return TextField(
      autofocus: true,
      style: theme.textTheme.bodyText1,
      obscureText: obstructText,
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
  initState() {
    obstructText = widget.obstructText;
    _visibliityKey = UniqueKey();
    _visibilityOffKey = UniqueKey();
    
    super.initState();
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
              if (widget.obstructText && widget.eyeButton)
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
