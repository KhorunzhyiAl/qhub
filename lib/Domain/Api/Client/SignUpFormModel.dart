import 'dart:async';

import 'package:qhub/Domain/Api/Enums/SignUpStatus.dart';
import 'package:qhub/Domain/Api/Client/ClientModel.dart';
import 'package:flutter/foundation.dart';
import 'package:qhub/Domain/Locators/Locator.dart';

class SignUpModel {
  ClientModel _clientModel = locator<ClientModel>();

  /// The following properties update every time [verifySignUpData] is called
  ValueNotifier<SignUpStatus> status = ValueNotifier(SignUpStatus.signUpDisabled);
  ValueNotifier<String?> usernameErrorNotifier = ValueNotifier(null);
  ValueNotifier<String?> password1ErrorNotifier = ValueNotifier(null);
  ValueNotifier<String?> password2ErrorNotifier = ValueNotifier(null);

  String _username = '';
  set username(String text) {
    _username = text;
    _verifyUsername();
    _updateStatus();
  }

  String _password1 = '';
  set password1(String text) {
    _password1 = text;
    _verifyPassword();
    _updateStatus();
  }

  String _password2 = '';
  set password2(String text) {
    _password2 = text;
    _verifyPassword();
    _updateStatus();
  }

  /// Makes a sign up request to the server. Returns true if successful.
  Future<bool> signUp() async {
    if (status.value != SignUpStatus.signUpEnabled) {
      return false;
    }

    _verifyUsername();
    _verifyPassword();

    status.value = SignUpStatus.busy;
    bool res = await _clientModel.signUp(_username, _password1);
    _updateStatus();
    return res;
  }

  void _verifyUsername() async {
    if (_username.isEmpty) {
      usernameErrorNotifier.value = 'Must not be empty';
      return;
    }
    if (_username.length > 20) {
      usernameErrorNotifier.value = 'Must contain 30 or less characters';
      return;
    }
    if (_username.length < 2) {
      usernameErrorNotifier.value = 'Must contain 2 or more characters';
      return;
    }
    if (_username.contains(' ')) {
      usernameErrorNotifier.value = 'Must not contain spaces';
      return;
    }

    usernameErrorNotifier.value = null;

    var usernameCopy = _username.toString();
    if (await Future<bool>.delayed(Duration(seconds: 2), () => true)) {
      if (_username == usernameCopy) {
        usernameErrorNotifier.value = 'Username is taken';
        status.value = SignUpStatus.signUpDisabled;
      }
      return;
    }
  }

  void _verifyPassword() {
    // MAIN PASSWORD CHECKS

    if (_password1.isEmpty) {
      password1ErrorNotifier.value = 'Must not be empty';
      return;
    }

    // password length >= 5
    if (_password1.length < 5) {
      password1ErrorNotifier.value = 'Password must contain 5 or more characters';
      return;
    }
    password1ErrorNotifier.value = null;

    // REPEAT PASSWORD CHECKS

    if (_password2.isEmpty) {
      password2ErrorNotifier.value = 'Must not be empty';
      return;
    }
    // Passwords match
    if (_password1 != _password2) {
      password2ErrorNotifier.value = 'Passwords do not match';
      return;
    }

    password2ErrorNotifier.value = null;
  }

  void _updateStatus() {
    if (usernameErrorNotifier.value == null &&
        password1ErrorNotifier.value == null &&
        password2ErrorNotifier.value == null &&
        _username.isNotEmpty &&
        _password1.isNotEmpty &&
        _password2.isNotEmpty) {
      print('username: $_username, password: $_password1, password2: $_password2');
      status.value = SignUpStatus.signUpEnabled;
      return;
    } else {
      status.value = SignUpStatus.signUpDisabled;
    }
  }
}
