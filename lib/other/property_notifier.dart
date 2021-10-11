import 'package:flutter/cupertino.dart';

/// Like [ValueNotifier], but lets you notify manually.
class PropertyNotifier<T> extends ValueNotifier<T> {
  PropertyNotifier(T value) : super(value);

  @override
  void notifyListeners() {
    super.notifyListeners();
  }
}