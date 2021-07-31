import 'dart:math';

import 'package:flutter/material.dart';

/// Shows a flip animation when the [child changes.
///
/// It's better to use a symetric curve because of  a current bug. Otherwise,
/// both widgets may be shown simultaniously.

enum FlipAxis {
  X,
  Y,
  Z,
}

class Flipper extends StatelessWidget {
  final Widget child;
  final Duration flipDuration;
  final Curve curve;
  final FlipAxis axis;

  Flipper({
    required this.child,
    this.flipDuration = const Duration(milliseconds: 300),
    this.curve = Curves.linear,
    this.axis = FlipAxis.Y,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: flipDuration,
      switchInCurve: curve,
      switchOutCurve: curve,
      child: child,
      transitionBuilder: (child, animation) {
        var rotateAnim = Tween(begin: 0.0, end: pi).animate(animation);
        return AnimatedBuilder(
          animation: rotateAnim,
          child: child,
          builder: (context, child) {
            final transformRotation;
            switch (axis) {
              case FlipAxis.X:
                transformRotation = Matrix4.rotationX(rotateAnim.value);
                break;
              case FlipAxis.Y:
                transformRotation = Matrix4.rotationY(rotateAnim.value);
                break;
              case FlipAxis.Z:
                transformRotation = Matrix4.rotationZ(rotateAnim.value);
                break;
            }

            return Transform(
              transform: transformRotation,
              alignment: Alignment.center,
              child: Visibility(
                visible: rotateAnim.value >= pi / 2,
                child: child!,
              ),
            );
          },
        );
      },
    );
  }
}
