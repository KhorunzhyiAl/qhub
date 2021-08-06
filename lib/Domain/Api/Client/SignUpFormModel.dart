import 'dart:async';

import 'package:qhub/Domain/Api/Enums/SignUpStatus.dart';
import 'package:flutter/foundation.dart';

class SignUpModel {
  /// The following properties update every time [verifySignUpData] is called
  ValueNotifier<SignUpStatus> status = ValueNotifier(SignUpStatus.incorrect);
  // ValueNotifier<String?> usernameErrorNotifier = ValueNotifier(null);
  // ValueNotifier<String?> password1ErrorNotifier = ValueNotifier(null);
  // ValueNotifier<String?> password2ErrorNotifier = ValueNotifier(null);

  var _usernameErrorStreamController = StreamController<String?>();
  var _password1ErrorStreamController = StreamController<String?>();
  var _password2ErrorStreamController = StreamController<String?>();

  Stream<String?> get usernameErrorStream => _usernameErrorStreamController.stream;
  Stream<String?> get password1ErrorStream => _password1ErrorStreamController.stream;
  Stream<String?> get password2ErrorStraem => _password2ErrorStreamController.stream;

  String? _username;
  set username(String text) {
    _username = text.length > 0 ? text : null;
  }

  String? _password1;
  set password1(String text) {
    _password1 = text.length > 0 ? text : null;
  }

  String? _password2;
  set password2(String text) {
    _password2 = text.length > 0 ? text : null;
  }

  /// Makes a sign up request to the server. Returns true if successful.
  Future<bool> signUp() async {
    if (status.value != SignUpStatus.correct) {
      return false;
    }
    return Future.delayed(Duration(seconds: 2), () => true);
  }

  void verifySignUpDataLocally() {
    bool hasError = false;

    // password length >= 5
    if (_password1 != null && _password1!.length < 5) {
      _password1ErrorStreamController.add('Password must contain 5 or more characters');
      hasError = true;
    } else {
      _password1ErrorStreamController.add(null);
    }

    // Passwords match
    if (_password1 != null && _password2 != null && _password1 != _password2) {
      _password2ErrorStreamController.add('Passwords do not match');
      hasError = true;
    } else {
      _password2ErrorStreamController.add(null);
    }

    // Username check
    if (_username != null) {
      var error;
      if (_username!.length > 20) {
        error = 'Must contain 30 or less characters';
      }
      if (_username!.length < 2) {
        error = 'Must contain 2 or more characters';
      }
      if (_username!.contains(' ')) {
        error = 'Must not contain spaces';
      }
      _usernameErrorStreamController.add(error);
    } else {
      _usernameErrorStreamController.add(null);
      hasError = true;
    }

    // Passwords not null
    if (_password1 == null || _password2 == null) {
      hasError = true;
    }

    switch (hasError) {
      case true:
        status.value = SignUpStatus.incorrect;
        break;
      case false:
        status.value = SignUpStatus.correct;
    }
  }

  Future<void> verifyUsername() async {
    if (_username != null) {
      var usernameCopy = _username.toString();
      if (await Future<bool>.delayed(Duration(seconds: 2), () => true)) {
        if (_username == usernameCopy) {
          _usernameErrorStreamController.add('Username is taken');
          status.value = SignUpStatus.incorrect;
        }
      }
    }
  }
}
