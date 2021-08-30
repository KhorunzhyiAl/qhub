import 'package:cookie_jar/cookie_jar.dart';
import 'package:flutter/cupertino.dart';
import 'package:qhub/Domain/Client/ClientStatus.dart';
import 'package:dio/dio.dart';
import 'package:qhub/Domain/Utils.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';

class Client {
  final _cookieJar = CookieJar();
  late final Dio dio;

  ValueNotifier<ClientStatus> _status = ValueNotifier(ClientStatus.starting);

  Client() {
    dio = Dio()
      ..options.baseUrl = Utils.SERVER_ADDRESS
      ..options.sendTimeout = 5000
      ..options.receiveTimeout = 5000
      ..options.connectTimeout = 5000
      ..interceptors.add(CookieManager(_cookieJar));
  }

  void addStatusListener(void Function(ClientStatus status) f) {
    _status.addListener(() {
      f(_status.value);
    });
  }

  Future<bool> signUp(String username, String password) async {
    Response resp;
    try {
      resp = await dio.post(
        '/user/register',
        data: 'username=$username&password=$password',
        options: Options(headers: {
          Headers.contentTypeHeader: 'application/x-www-form-urlencoded',
        }),
      );
    } catch (e) {
      print(e);
      _status.value = ClientStatus.connectionError;
      return false;
    }

    Map<String, dynamic> respData = resp.data;
    bool success = respData['status'] == 'success';

    if (success) _status.value = ClientStatus.loggedIn;
    return success;
  }

  /// Makes a log in request to the server. Sets the status to [ClientStatus.loggedIn] in case of
  /// success;
  Future<bool> logInWithPassword(String username, String password) async {
    Response resp;
    try {
      resp = await dio.post(
        '/user/login',
        data: 'username=$username&password=$password',
        options: Options(headers: {
          Headers.contentTypeHeader: 'application/x-www-form-urlencoded',
        }),
      );
    } catch (e) {
      print(e);
      print('connection error. updating _status');
      _status.value = ClientStatus.connectionError;
      print('status updated');
      return false;
    }

    Map<String, dynamic> respData = resp.data;
    bool success = respData['status'] == 'success';

    if (success) {
      _status.value = ClientStatus.loggedIn;
    }
    return success;
  }

  /// If there is a token, makes a request to verify it. Sets the status to [ClientStatus.loggedIn]
  /// in case of success;
  Future<bool> logInWithToken() async {
    Response resp;
    try {
      resp = await dio.get('/user/tokencheck');
    } catch (e) {
      print(e);
      _status.value = ClientStatus.connectionError;
      return false;
    }

    Map<String, dynamic> respData = resp.data;
    bool success = respData['status'] == 'success';

    if (success) {
      _status.value = ClientStatus.loggedIn;
    } else {
      _status.value = ClientStatus.loggedOut;
    }

    return success;
  }

  void logOut() {
    _status.value = ClientStatus.loggedOut;
  }
}
