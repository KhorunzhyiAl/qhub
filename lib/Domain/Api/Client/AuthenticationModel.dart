import 'package:qhub/Domain/Api/Enums.dart';


class AuthenticationModel {
  /// Makes a log in request to the server. Returns true if successfull.
  /// TODO: currently a dummy.
  static Future<bool> logInWithPassword(
      String username, String password) async {
    return Future.delayed(Duration(seconds: 2), () => true);
  }

  /// If there is a token, makes a request to verify it. Returns true if the token is verified.
  static Future<bool> logInWithToken() async {
    return Future.delayed(Duration(seconds: 2), () => false);
  }
}
