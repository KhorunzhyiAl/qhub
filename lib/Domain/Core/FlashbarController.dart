import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:qhub/Domain/Core/Failure.dart';

class FlashbarController {
  final _message = ValueNotifier<Failure>(Failure(message: None()));
  ValueListenable<Failure> get message => _message;

  void send(String text) {
    _message.value = Failure(message: Some(text));
  }
}

