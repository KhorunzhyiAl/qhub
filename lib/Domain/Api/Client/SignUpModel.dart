import 'package:qhub/Domain/Api/Enums.dart';
import 'package:flutter/foundation.dart';

class SignUpModel {
  /// The following properties update every time [verifySignUpData] is called
  ValueNotifier<SignUpStatus> status = ValueNotifier(SignUpStatus.correct);
  ValueNotifier<List<String>> usernameErrorNotifier = ValueNotifier([]);
  ValueNotifier<String?> password1ErrorNotifier = ValueNotifier(null);
  ValueNotifier<String?> password2ErrorNotifier = ValueNotifier(null);



  String? _username;
  set username(String text) {
    _username = text.length > 0 ? text : null;
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
    if (_password1 != null && _password1!.length < 5) {
      password1ErrorNotifier.value = 'Password must contain 5 or more characters';
      status.value = SignUpStatus.incorrect;
    } else {
      password1ErrorNotifier.value = null;
    }

    if (_password1 != null && _password2 != null && _password1 != _password2) {
      password2ErrorNotifier.value = 'Passwords do not match';
      status.value = SignUpStatus.incorrect;
    } else {
      password2ErrorNotifier.value = null;
    }

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
      status.value = usernameErrors.length > 0 ? SignUpStatus.incorrect : SignUpStatus.correct;

      // Chek if not taken;
      // TODO: dummy
      if (await Future<bool>.delayed(Duration(seconds: 2), () => false)) {
        usernameErrors.add('Username is taken');
        usernameErrorNotifier.value = usernameErrors;
        status.value = SignUpStatus.incorrect;
      }
    } else {
      usernameErrorNotifier.value = [];
      status.value = SignUpStatus.incorrect;
    }
  }
}
