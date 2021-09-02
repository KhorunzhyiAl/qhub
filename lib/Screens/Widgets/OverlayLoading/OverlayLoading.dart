import 'package:flutter/material.dart';
import 'package:qhub/Screens/Widgets/OverlayLoading/Other/OverlayLoadingController.dart';
export 'package:qhub/Screens/Widgets/OverlayLoading/Other/OverlayLoadingController.dart';


class OverlayLoading extends StatelessWidget {
  final OverlayLoadingController controller;

  OverlayLoading({required this.controller});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final containerKey = UniqueKey();

    return ValueListenableBuilder<bool>(
      valueListenable: controller.visible,
      builder: (_, visible, __) {
        if (!visible) {
          return IgnorePointer(

            child: AnimatedContainer(
              key: containerKey,
              duration: Duration(milliseconds: 200),
              color: Colors.transparent,
            ),
          );
        }
        return AnimatedContainer(
          key: containerKey,
          duration: Duration(milliseconds: 400),
          color: theme.colorScheme.surface.withAlpha(100),
          child: Center(
            child: CircularProgressIndicator(
              color: theme.colorScheme.onSurface,
              backgroundColor: Colors.transparent,
            ),
          ),
        );
      },
    );
  }
}
