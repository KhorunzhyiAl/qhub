import 'package:dartz/dartz.dart';
import 'package:qhub/domain/core/client/client.dart';
import 'package:flutter/foundation.dart';
import 'package:qhub/domain/core/flashbar_controller.dart';
import 'package:qhub/domain/locators.dart';

enum LogInStatus {
  loading,
  enabled,
  disabled,
}

class LogInFormModel {
  final _client = locator<Client>();
  final _flashbar = locator<FlashbarController>();

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

    final res = await _client.logInWithPassword(_username, _password);
    print('log in with password. res = ${res.toString()}');
    res.fold(
      (l) {
        _flashbar.send(l);
      },
      (r) {
        logInErrorNotifier.value = None();
      },
    );
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
