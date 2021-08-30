import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:qhub/Domain/Client/Client.dart';
import 'package:flutter/foundation.dart';
import 'package:qhub/Domain/Locators.dart';

enum SignUpStatus {
  enabled,
  disabled,
  busy,
}

class SignUpFormModel {
  final _client = locator<Client>();

  ValueNotifier<SignUpStatus> status = ValueNotifier(SignUpStatus.disabled);
  ValueNotifier<Option<String>> usernameErrorNotifier = ValueNotifier(None());
  ValueNotifier<Option<String>> password1ErrorNotifier = ValueNotifier(None());
  ValueNotifier<Option<String>> password2ErrorNotifier = ValueNotifier(None());

  String _username = '';
  set username(String t) {
    _username = t;
    touchedUsername = true;
  }

  String _password1 = '';
  set password1(String t) {
    _password1 = t;
    touchedPassword1 = true;
  }

  String _password2 = '';
  set password2(String t) {
    _password2 = t;
    touchedPassword2 = true;
  }

  bool touchedUsername = false;
  bool touchedPassword1 = false;
  bool touchedPassword2 = false;

  /// Makes a sign up request to the server. Returns true if successful.
  Future<bool> signUp() async {
    if (status.value != SignUpStatus.enabled) return false;

    status.value = SignUpStatus.busy;

    bool correct = true;
    correct &= _verifyUsername();
    correct &= _verifyPassword();

    if (!correct) return false;

    // TODO: Instead of a bool this should return an error telling what went wrong. At least a
    // username taken error.
    bool res = await _client.signUp(_username, _password1);

    status.value = SignUpStatus.enabled;

    return res;
  }

  void verifyFields() async {
    bool correct = true;
    correct &= _verifyUsername();
    correct &= _verifyPassword();

    if (correct) {
      status.value = SignUpStatus.enabled;
    } else {
      status.value = SignUpStatus.disabled;
    }

    if (!(await _verifyUsernameNotTaken())) {
      status.value = SignUpStatus.disabled;
    }
  }

  bool _verifyUsername() {
    if (_username.isEmpty) {
      usernameErrorNotifier.value = Some('Must not be empty');
      return false;
    }

    if (_username.length > 20) {
      usernameErrorNotifier.value = Some('Must contain 30 or less characters');
      return false;
    }

    if (_username.length < 2) {
      usernameErrorNotifier.value = Some('Must contain 2 or more characters');
      return false;
    }

    if (_username.contains(' ')) {
      usernameErrorNotifier.value = Some('Must not contain spaces');
      return false;
    }

    usernameErrorNotifier.value = None();

    return true;
  }

  Future<bool> _verifyUsernameNotTaken() async {
    var usernameCopy = _username.toString();
    if (await Future<bool>.delayed(Duration(seconds: 2), () => false)) {
      // Username might change by the time the response arrives, in which case the warning will not
      // be relevant.
      if (_username == usernameCopy) {
        usernameErrorNotifier.value = Some('Username is taken');
        status.value = SignUpStatus.disabled;
        return false;
      }
    }
    return true;
  }

  bool _verifyPassword() {
    if (_password1.isEmpty) {
      password1ErrorNotifier.value = Some('Must not be empty');
      return false;
    }

    if (_password1.length < 5) {
      password1ErrorNotifier.value = Some('Password must contain 5 or more characters');
      return false;
    }
    password1ErrorNotifier.value = None();

    if (_password2.isEmpty) {
      password2ErrorNotifier.value = Some('Must not be empty');
      return false;
    }

    if (_password1 != _password2) {
      password2ErrorNotifier.value = Some('Passwords do not match');
      return false;
    }

    password2ErrorNotifier.value = None();

    return true;
  }
}
