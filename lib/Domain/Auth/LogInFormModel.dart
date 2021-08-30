import 'package:dartz/dartz.dart';
import 'package:qhub/Domain/Client/Client.dart';
import 'package:flutter/foundation.dart';
import 'package:qhub/Domain/Locators.dart';

enum LogInStatus {
  loading,
  enabled,
  disabled,
}

class LogInFormModel {
  final _client = locator<Client>();


  ValueNotifier<LogInStatus> status = ValueNotifier(LogInStatus.disabled);

  /// Stuff like "incorrect username or password". Updates when calling [logIn]
  ValueNotifier<Option<String>> logInErrorNotifier = ValueNotifier(None());
  ValueNotifier<Option<String>> usernameErrorNotifier = ValueNotifier(None());
  ValueNotifier<Option<String>> passwordErrorNotifier = ValueNotifier(None());

  String _username = '';
  String _password = '';
  bool touchedUsername = false;
  bool touchedPassword = false;

  set username(String t) {
    _username = t;
    touchedUsername = true;
  }

  set password(String t) {
    _password = t;
    touchedPassword = true;
  }

  Future<bool> logIn() async {
    validateFields();
    if (status.value != LogInStatus.enabled) return false;

    status.value = LogInStatus.loading;
    if (await _client.logInWithPassword(_username, _password)) {
      logInErrorNotifier.value = None();
    } else {
      logInErrorNotifier.value = Some('Incorrect username or password');
    }
    status.value = LogInStatus.enabled;

    return true;
  }

  void validateFields() {
    bool errorFlag = false;

    if (_username.isEmpty) {
      usernameErrorNotifier.value = Some('Username is empty');
      errorFlag = true;
    } else {
      usernameErrorNotifier.value = None();
    }

    if (_password.isEmpty) {
      passwordErrorNotifier.value = Some('Password is empty');
      errorFlag = true;
    } else {
      passwordErrorNotifier.value = None();
    }

    if (errorFlag) {
      status.value = LogInStatus.disabled;
    } else {
      status.value = LogInStatus.enabled;
    }
  }
}
