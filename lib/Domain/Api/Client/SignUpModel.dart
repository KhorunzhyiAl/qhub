import 'package:qhub/Domain/Api/Enums.dart';
import 'package:flutter/foundation.dart';

class SignUpModel {
  /// The following properties update every time [verifySignUpData] is called
  ValueNotifier<SignUpStatus> status = ValueNotifier(SignUpStatus.incorrect);
  ValueNotifier<List<String>> usernameErrorNotifier = ValueNotifier([]);
  ValueNotifier<String?> password1ErrorNotifier = ValueNotifier(null);
  ValueNotifier<String?> password2ErrorNotifier = ValueNotifier(null);

  String? _username;
  set username(String text) {
    _username = text.length > 0 ? text : null;
    print('username changed: $_username');
    _verifySignUpData();
  }

  String? _password1;
  set password1(String text) {
    _password1 = text.length > 0 ? text : null;
    _verifySignUpData();
  }

  String? _password2;
  set password2(String text) {
    _password2 = text.length > 0 ? text : null;
    _verifySignUpData();
  }

  /// Makes a sign up request to the server. Returns true if successful.
  /// TODO: this is a dummy.
  Future<bool> signUp() async {
    if (status.value != SignUpStatus.correct) {
      return false;
    }
    return Future.delayed(Duration(seconds: 2), () => true);
  }

  /// Verifies the data from the sign up fields. First checks for mistakes that don't require a
  /// server request (e.g.: disallowed characters in username, etc.), then the rest (if the
  /// username is taken, for example).
  /// Doesn't compare passwords if [repeatPassword] is null.
  /// TODO: currently all the checks a made up. Match the requirements with the server's.
  Future<void> _verifySignUpData() async {
    bool hasError = false;

    // password length >= 5
    if (_password1 != null && _password1!.length < 5) {
      password1ErrorNotifier.value = 'Password must contain 5 or more characters';
      hasError = true;
    } else {
      password1ErrorNotifier.value = null;
    }

    // Passwords match
    if (_password1 != null && _password2 != null && _password1 != _password2) {
      password2ErrorNotifier.value = 'Passwords do not match';
      hasError = true;
    } else {
      password2ErrorNotifier.value = null;
    }

    // Username check
    if (_username != null) {
      var usernameErrors = <String>[];
      if (_username!.length > 20) {
        usernameErrors.add('Must contain 30 or less characters');
      }
      if (_username!.length < 2) {
        usernameErrors.add('Must contain 2 or more characters');
      }
      if (_username!.contains(' ')) {
        usernameErrors.add('Must not contain spaces');
      }

      usernameErrorNotifier.value = usernameErrors;
      hasError |= usernameErrors.length > 0;
    } else {
      usernameErrorNotifier.value = [];
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

    // Username taken check (queries the server)
    if (_username != null) {
      var usernameCopy = _username.toString();
      if (await Future<bool>.delayed(Duration(seconds: 2), () => true)) {
        if (_username == usernameCopy) {
          usernameErrorNotifier.value = usernameErrorNotifier.value + ['Username is taken'];
          hasError = true;
          status.value = SignUpStatus.incorrect;
        }
      }
    }
  }
}
