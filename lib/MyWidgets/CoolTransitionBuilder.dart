import 'package:flutter/material.dart';
import 'dart:math';

/// Shouldn't be used everywhere, because it takes more time than a normal transition.
class CoolTransitionBuilder extends StatefulWidget {
  final Widget child;
  bool _isFinished = false;

  CoolTransitionBuilder({
    required this.child,
  });

  @override
  _CoolTransitionBuilderState createState() => _CoolTransitionBuilderState();
}

class _CoolTransitionBuilderState extends State<CoolTransitionBuilder> {
  @override
  Widget build(BuildContext context) {
    final Size size;
    switch (MediaQuery.of(context).orientation) {
      case Orientation.portrait:
        size = MediaQuery.of(context).size;
        break;
      case Orientation.landscape:
        size = MediaQuery.of(context).size.flipped;
        break;
    }

    const offset = 1.5;
    const rippleWidth = 0.2;

    var coef =
        sqrt(pow(offset, 2) + pow(size.height * (offset) / size.width, 2));
    coef = coef / (1 - rippleWidth);
    coef += 0.2;

    if (widget._isFinished)
      return widget.child;
    else
      return Container(
        color: Colors.white,
        child: TweenAnimationBuilder(
          duration: const Duration(milliseconds: 600),
          tween: Tween<double>(begin: 0.0, end: 1),
          onEnd: () {
            setState(() {
              widget._isFinished = true;
            });
          },
          builder: (context, double value, child) {
            return ShaderMask(
              shaderCallback: (rect) {
                return RadialGradient(
                  radius: value * (coef),
                  colors: [
                    Colors.white,
                    Colors.black,
                    Colors.black,
                    Colors.transparent,
                  ],
                  stops: [1 - rippleWidth, 1 - rippleWidth, 1.0, 1.0],
                  center: FractionalOffset(offset, offset),
                ).createShader(rect);
              },
              child: child,
            );
          },
          child: widget.child,
        ),
      );
  }
}
