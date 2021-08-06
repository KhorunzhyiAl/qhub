import 'package:qhub/Domain/Api/Client/ClientModel.dart';
import 'package:flutter/foundation.dart';
import 'package:qhub/Domain/Api/Enums/LogInStatus.dart';
import 'package:qhub/Domain/Locators/Locator.dart';

class LogInFormModel {
  ClientModel clientModel = locator<ClientModel>();

  ValueNotifier<LogInStatus> status = ValueNotifier(LogInStatus.empty);
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
    if (_username == null) {
      usernameErrorNotifier.value = 'Username must not be empty';
    }
    if (_password == null) {
      passwordErrorNotifier.value = 'Password must not be empty';
    }

    if (await clientModel.logInWithPassword(_username!, _password!)) {
      passwordErrorNotifier.value = null;
    } else{
      passwordErrorNotifier.value = 'Incorrect username or password';
    }
  }

  void _validateFields() {
    if (_username != null && _password != null) {
      status.value = LogInStatus.filled;
    } else {
      status.value = LogInStatus.empty;
    }
  }
}
