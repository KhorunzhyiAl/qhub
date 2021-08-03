import 'package:qhub/Domain/Api/Enums.dart';
import 'package:flutter/foundation.dart';

class SignUpModel {
  /// Updates every time [verifySignUpData] is called
  static ValueNotifier<SignUpStatus> signUpStatusNotifier =
      ValueNotifier(SignUpStatus.correct);

  /// Makes a sign up request to the server. Returns true if successful.
  /// TODO: this is a dummy.
  static Future<bool> signUp(username, String password) async {
    return Future.delayed(Duration(seconds: 2), () => true);
  }

  /// Verifies the data from the sign up fields. First checks for mistakes that don't require a
  /// server request (e.g.: disallowed characters in username, etc.), then the rest (if the
  /// username is taken, for example).
  /// Doesn't compare passwords if [repeatPassword] is null.
  /// TODO: currently all the checks a made up. Match the requirements with the server's.
  static void verifySignUpData({
    required String username,
    required String password,
    String? repeatPassword,
  }) async {
    if (repeatPassword != null && password != repeatPassword) {
      signUpStatusNotifier.value = SignUpStatus.passwordsNotMatch;
    }
    if (username.length > 30 || username.length < 2) {
      signUpStatusNotifier.value = SignUpStatus.incorrectUsername;
    }

    // temp
    await Future.delayed(Duration(seconds: 2));

    signUpStatusNotifier.value = SignUpStatus.correct;
  }
}