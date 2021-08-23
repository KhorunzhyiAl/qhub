import 'dart:math';

import 'package:flutter/material.dart';
import 'package:qhub/Screens/Widgets/FloatingButton/Other/FloatingPopupElement.dart';

/// Shows a list of options (create post, write comment, etc.) when the floating button gets
/// clicked. The list of options can be specified differently for each screen using the [options]
/// property.
///
/// Stack this widget on top of a page using [Stack]. Can't be used inside [floatingActionButton]
/// property. This is needed for tinting the background screen when menu is shown.
class FloatingPopup extends StatefulWidget {
  final List<FloatingPopupElement> options;

  FloatingPopup({required this.options});

  @override
  _FloatingPopupState createState() => _FloatingPopupState();
}

class _FloatingPopupState extends State<FloatingPopup> with TickerProviderStateMixin {
  late final AnimationController _ctrler;
  bool _toggled = false;

  @override
  void initState() {
    _ctrler = AnimationController(duration: Duration(milliseconds: 400), vsync: this);
    widget.options.forEach((e) {
      e.addOnPressedCallback(_hide);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const mainButtonSize = 55.0;
    const mainMargin = EdgeInsets.all(20);

    final theme = Theme.of(context);

    /// Animates fading of popup buttons
    Animation<double> animPopupFading = _ctrler.drive(CurveTween(curve: Curves.easeInOutSine));

    /// Animates popup buttons
    Animation<double> animPopupButtons;

    /// Takes a fraction of the total anmation time ([Interval]). Animates background opacity
    Animation<double> animFast;

    if (_toggled) {
      animPopupButtons = _ctrler.drive(CurveTween(curve: Curves.elasticOut));
      animFast = _ctrler.drive(CurveTween(curve: Interval(0, 0.4, curve: Curves.easeInOutSine)));

      _ctrler.forward();
    } else {
      animPopupButtons = _ctrler.drive(CurveTween(curve: Curves.easeOutCubic));
      animFast = _ctrler.drive(CurveTween(curve: Interval(0.6, 1, curve: Curves.easeInOutSine)));

      _ctrler.reverse();
    }

    return AnimatedBuilder(
      animation: _ctrler,
      builder: (_, __) {
        return Stack(
          alignment: Alignment.bottomRight,
          children: [
            IgnorePointer(
              ignoring: !_toggled,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _toggled = false;
                  });
                },
                child: Container(
                  color: theme.colorScheme.background.withOpacity(0.95 * animFast.value),
                  alignment: Alignment.bottomRight,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [],
                  ),
                ),
              ),
            ),

            // a bit ugly
            FadeTransition(
              opacity: animPopupFading,
              child: Container(
                color: Colors.transparent,
                height: (_toggled || _ctrler.isAnimating
                    ? mainButtonSize + widget.options.length * FloatingPopupElement.totalDiameter
                    : 0),
                margin: mainMargin,
                padding: EdgeInsets.all((mainButtonSize - FloatingPopupElement.diameter) / 2),
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    ...List<Widget>.generate(widget.options.length, (index) {
                      return Positioned(
                        bottom: (mainButtonSize + FloatingPopupElement.totalDiameter * index) *
                            animPopupButtons.value,
                        child: widget.options[index],
                      );
                    }),
                  ],
                ),
              ),
            ),

            Container(
              margin: mainMargin,
              child: SizedBox(
                height: mainButtonSize,
                width: mainButtonSize,
                child: FloatingActionButton(
                  onPressed: () {
                    setState(() {
                      _toggled = !_toggled;
                    });
                  },
                  splashColor: theme.colorScheme.secondaryVariant,
                  backgroundColor: theme.colorScheme.secondary,
                  foregroundColor: theme.colorScheme.onSecondary,
                  child: Transform.rotate(
                    angle: 1 / 4 * pi * animFast.value,
                    child: Icon(
                      Icons.add,
                      size: 35 - 15 * min(animFast.value, 1 - animFast.value),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _hide() {
    setState(() {
      _toggled = false;
    });
  }
}
