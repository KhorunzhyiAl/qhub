import 'package:flutter/cupertino.dart';
import 'package:qhub/Domain/Enums/ClientStatus.dart';

class Service {
  ValueNotifier<ClientStatus> _status = ValueNotifier(ClientStatus.starting);

  void addStatusListener(void Function(ClientStatus status) f) {
    _status.addListener(() {
      f(_status.value);
    });
  }

  Future<bool> signUp(String username, String password) async {
    return Future.delayed(Duration(seconds: 2), () => false);
  }

  void logOut() {
    _status.value = ClientStatus.loggedOut;
  }

  /// Makes a log in request to the server. Sets the status to [ClientStatus.loggedIn] if case of
  /// success;
  Future<bool> logInWithPassword(String username, String password) async {
    if (await Future.delayed(Duration(seconds: 2), () => false)) {
      _status.value = ClientStatus.loggedIn;
      return true;
    }
    return false;
  }

  /// If there is a token, makes a request to verify it. Sets the status to [ClientStatus.loggedIn]
  /// if case of success;
  Future<bool> logInWithToken() async {
    if (await Future.delayed(Duration(seconds: 2), () => false)) {
      _status.value = ClientStatus.loggedIn;
      return true;
    } else {
      _status.value = ClientStatus.loggedOut;
      return false;
    }
  }
}
