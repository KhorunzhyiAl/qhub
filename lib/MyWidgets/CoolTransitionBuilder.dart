import 'package:flutter/material.dart';

/// Shouldn't be used everywhere, because it takes more time than a normal transition.
class CoolTransitionBuilder extends StatelessWidget {
  Widget child;

  CoolTransitionBuilder({
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: TweenAnimationBuilder(
        duration: Duration(milliseconds: 600),
        tween: Tween<double>(begin: 0.0, end: 1),
        
        builder: (context, double value, child) {
          return ShaderMask(
            shaderCallback: (rect) {
              return RadialGradient(
                radius: value * 4,
                colors: [Colors.white, Colors.transparent],
                stops: [1.0, 1.0],
                center: FractionalOffset(1.5, 1.5),
              ).createShader(rect);
            },
            child: child,
          );
        },

        child: child,
      ),
    );
  }
}
