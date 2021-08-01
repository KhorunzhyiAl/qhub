import 'package:flutter/material.dart';

/// Shouldn't be used everywhere, because it takes more time than a normal transition.
class CoolTransitionBuilder extends StatelessWidget {
  Widget child;

  CoolTransitionBuilder({
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      duration: const Duration(milliseconds: 600),
      tween: Tween<double>(begin: 0.0, end: 1),
      builder: (context, double value, child) {
        return ShaderMask(
          shaderCallback: (rect) {
            return RadialGradient(
              radius: value * 5,
              colors: [Colors.white, Colors.black],
              stops: [1.0, 1.0],
              center: FractionalOffset(1.3, 2),
            ).createShader(rect);
          },
          child: child,
        );
      },
      child: child,
    );
  }
}
