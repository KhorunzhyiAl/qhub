import 'package:flutter/material.dart';

class SeparatorWidget extends StatelessWidget {
  final String text;

  SeparatorWidget({required this.text});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      height: 35,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(child: Divider()),
          SizedBox(width: 10),
          Text(text, style: theme.textTheme.headline6),
          SizedBox(width: 10),
          Expanded(child: Divider()),
        ],
      ),
    );
  }
}
