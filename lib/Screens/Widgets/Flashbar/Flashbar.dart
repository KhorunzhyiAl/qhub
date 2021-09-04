import 'dart:math';

import 'package:flutter/material.dart';
import 'package:qhub/Domain/Core/Failure.dart';
import 'package:qhub/Domain/Core/FlashbarController.dart';

class Flashbar extends StatefulWidget {
  final FlashbarController controller;

  Flashbar(this.controller);

  @override
  _FlashbarState createState() => _FlashbarState();
}

class _FlashbarState extends State<Flashbar> with SingleTickerProviderStateMixin {
  late final AnimationController animController;
  late final Animation<double> animShow;
  late final Animation<double> animFade;
  Failure? last;
  late final Widget flashbarWidget;
  late final OverlayEntry overlay;
  final double fadeStarts = 0.9;

  @override
  void initState() {
    animController = AnimationController(duration: Duration(seconds: 4), vsync: this);
    animShow = animController.drive(CurveTween(
      curve: Interval(
        0.0,
        0.1,
        curve: Curves.easeInOutSine,
      ),
    ));
    animFade = animController.drive(CurveTween(
      curve: Interval(
        fadeStarts,
        1,
        curve: Curves.easeInOutSine,
      ),
    ));

    super.initState();
  }

  @override
  void dispose() {
    overlay.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;

    final widgetsBinding = WidgetsBinding.instance;
    EdgeInsetsGeometry insets = EdgeInsets.symmetric(vertical: 10, horizontal: 10);
    if (widgetsBinding != null) {
      insets = insets.add(EdgeInsets.fromWindowPadding(
        widgetsBinding.window.viewInsets,
        widgetsBinding.window.devicePixelRatio,
      ));
    }

    return Positioned(
      bottom: 0,
      right: 0,
      left: 0,
      child: Padding(
        padding: insets,
        child: ValueListenableBuilder<Failure>(
          valueListenable: widget.controller.message,
          builder: (_, failure, __) {
            if (failure.message.isNone()) {
              return SizedBox.shrink();
            }

            if (!animController.isAnimating && (last != failure) || (last != failure)) {
              animController.reset();
              animController.forward();
            }

            last = failure;

            return AnimatedBuilder(
              animation: animController,
              builder: (_, __) {
                if (animController.value == 1.0) {
                  return SizedBox.shrink();
                }

                return Opacity(
                  opacity: 1 - animFade.value,
                  child: Opacity(
                    opacity: animShow.value,
                    child: Container(
                      width: min(400, size.width - 40),
                      child: Card(
                        color: theme.colorScheme.onBackground,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                          child: Row(
                            children: [
                              Text(
                                failure.message.foldRight('', (a, previous) => a),
                                style: theme.textTheme.headline6?.copyWith(
                                  color: theme.colorScheme.background,
                                ),
                              ),
                              Spacer(),
                              TextButton(
                                onPressed: () {
                                  animController.value = max(fadeStarts, animController.value);
                                  animController.forward();
                                },
                                child: Text('OK'),
                                style: ButtonStyle(
                                  foregroundColor: MaterialStateProperty.all<Color>(
                                    Colors.blue.shade300,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
