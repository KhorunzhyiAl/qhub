import 'package:flutter/foundation.dart';

class OverlayLoadingController {
  final _visible = ValueNotifier<bool>(false);
  ValueListenable<bool> get visible => _visible;


  void show() {
    _visible.value = true;
  }

  void hide() {
    _visible.value = false;
  }
}