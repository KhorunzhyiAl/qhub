import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:qhub/domain/core/failure.dart';

class FlashbarController {
  // TODO: maybe this should provid only the message string? (Problems )
  final _message = ValueNotifier<Failure>(Failure(type: FailureType.any, message: None()));
  ValueListenable<Failure> get message => _message;

  void send(Failure failure) {
    _message.value = failure;
  }
}
