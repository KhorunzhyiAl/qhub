import 'package:flutter/material.dart';

class ErrorText extends StatelessWidget {
  final String? error;

  ErrorText(this.error);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      height: error != null ? 25 : 0,
      curve: Curves.easeOutSine,
      alignment: Alignment.centerLeft,
      child: error != null
          ? Text(
              error!,
              style: theme.textTheme.caption?.copyWith(color: theme.errorColor),
            )
          : null,
    );
  }
}
