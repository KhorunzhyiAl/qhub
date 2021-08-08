import 'package:qhub/Domain/Services/ClientService.dart';
import 'package:flutter/foundation.dart';
import 'package:qhub/Domain/Services/Enums/LogInStatus.dart';
import 'package:qhub/Domain/Locators/Locator.dart';

class LogInFormModel {
  ClientService clientModel = locator<ClientService>();

  ValueNotifier<LogInStatus> status = ValueNotifier(LogInStatus.logInDisabled);
  ValueNotifier<String?> usernameErrorNotifier = ValueNotifier(null);
  ValueNotifier<String?> passwordErrorNotifier = ValueNotifier(null);

  String? _username;
  String? _password;

  set username(String text) {
    _username = text.isEmpty ? null : text;
    _validateFields();
  }

  set password(String text) {
    _password = text.isEmpty ? null : text;
    _validateFields();
  }

  void logIn() async {
    if (status.value != LogInStatus.logInEnabled) {
      return;
    }
    if (_username == null) {
      usernameErrorNotifier.value = 'Username must not be empty';
    }
    if (_password == null) {
      passwordErrorNotifier.value = 'Password must not be empty';
    }

    status.value = LogInStatus.busy;
    if (await clientModel.logInWithPassword(_username!, _password!)) {
      passwordErrorNotifier.value = null;
    } else {
      passwordErrorNotifier.value = 'Incorrect username or password';
    }
    status.value = LogInStatus.logInEnabled;
  }

  void _validateFields() {
    if (_username != null && _password != null) {
      status.value = LogInStatus.logInEnabled;
      passwordErrorNotifier.value = null;
    } else {
      status.value = LogInStatus.logInDisabled;
    }
  }
}
