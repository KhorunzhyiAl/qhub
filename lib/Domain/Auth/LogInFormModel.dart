import 'package:qhub/Domain/Client/Client.dart';
import 'package:flutter/foundation.dart';
import 'package:qhub/Domain/Auth/LogInStatus.dart';
import 'package:qhub/Domain/Locators.dart';


class LogInFormModel {
  final _client = locator<Client>();

  ValueNotifier<LogInStatus> status = ValueNotifier(LogInStatus.logInDisabled);
  ValueNotifier<String?> usernameErrorNotifier = ValueNotifier(null);
  ValueNotifier<String?> passwordErrorNotifier = ValueNotifier(null);

  String _username = '';
  String _password = '';

  set username(String text) {
    _username = text;
    _validateFields();
  }

  set password(String text) {
    _password = text;
    _validateFields();
  }

  void logIn() async {
    if (status.value != LogInStatus.logInEnabled) {
      return;
    }
    if (_username.isEmpty) {
      usernameErrorNotifier.value = 'Username must not be empty';
    }
    if (_password.isEmpty) {
      passwordErrorNotifier.value = 'Password must not be empty';
    }

    status.value = LogInStatus.busy;
    if (await _client.logInWithPassword(_username, _password)) {
      passwordErrorNotifier.value = null;
    } else {
      passwordErrorNotifier.value = 'Incorrect username or password';
    }
    status.value = LogInStatus.logInEnabled;
  }

  void _validateFields() {
    if (_username.isNotEmpty && _password.isNotEmpty) {
      status.value = LogInStatus.logInEnabled;
      passwordErrorNotifier.value = null;
    } else {
      status.value = LogInStatus.logInDisabled;
    }
  }
}
