import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:qhub/Domain/Api/Enums/ClientStatus.dart';

class ClientModel {
  ValueNotifier<ClientStatus> status = ValueNotifier(ClientStatus.trying);
  ValueNotifier<bool> isBusy = ValueNotifier(false);

  void addStatusListener(void Function(ClientStatus status) f) {
    status.addListener(() {
      f(status.value);
    });
  }

  void logOut() {
    status.value = ClientStatus.loggedOut;
  }

  /// Makes a log in request to the server. Sets the status to [ClientStatus.loggedIn] if case of
  /// success;
  Future<bool> logInWithPassword(String username, String password) async {
    isBusy.value = true;
    if (await Future.delayed(Duration(seconds: 2), () => false)) {
      status.value = ClientStatus.loggedIn;
      return true;
    }
    isBusy.value = false;
    return false;
  }

  /// If there is a token, makes a request to verify it. Sets the status to [ClientStatus.loggedIn]
  /// if case of success;
  Future<void> logInWithToken() async {
    isBusy.value = true;
    if (await Future.delayed(Duration(seconds: 2), () => false)) {
      status.value = ClientStatus.loggedIn;
    } else if (status.value == ClientStatus.trying) {
      status.value = ClientStatus.loggedOut;
    }
    isBusy.value = false;
  }
}
