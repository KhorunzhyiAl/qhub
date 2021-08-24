import 'package:flutter/material.dart';

class FloatingPopupElement extends StatelessWidget {
  // These are used for [FloatingPopup] to arrenge the elements.
  static const diameter = 44.0;
  static const margins = 15.0;
  static const totalDiameter = diameter + margins * 2;

  final String _message;
  final IconData _icon;
  final _onPressedCallbacks = List<void Function()>.empty(growable: true);

  FloatingPopupElement({required message, required icon, required onPressed})
      : _message = message,
        _icon = icon {
    _onPressedCallbacks.add(onPressed);
  }

  void addOnPressedCallback(void Function() f) {
    _onPressedCallbacks.add(f);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              _onPressedCallbacks.forEach((e) => e.call());
            },
            child: Text(_message, style: theme.textTheme.caption),
          ),
          SizedBox(width: 15),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 0, vertical: margins),
            height: diameter,
            width: diameter,
            decoration: BoxDecoration(
              color: theme.colorScheme.secondary,
              borderRadius: BorderRadius.circular(diameter / 2),
            ),
            child: FloatingActionButton(
              heroTag: UniqueKey(),
              elevation: 0,
              onPressed: () {
                _onPressedCallbacks.forEach((e) => e.call());
              },
              child: Icon(_icon),
              splashColor: theme.colorScheme.secondaryVariant,
            ),
          ),
        ],
      ),
    );
  }
}
