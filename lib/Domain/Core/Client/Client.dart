import 'package:cookie_jar/cookie_jar.dart';
import 'package:dartz/dartz.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:qhub/Domain/Core/Client/ClientStatus.dart';
import 'package:dio/dio.dart';
import 'package:qhub/Domain/Core/Failure.dart';
import 'package:qhub/Domain/Core/FlashbarController.dart';
import 'package:qhub/Domain/Locators.dart';
import 'package:qhub/Domain/Utils.dart';

export 'package:qhub/Domain/Core/Client/ClientStatus.dart';

class Client {
  late final Dio dio;
  final _flashbar = locator<FlashbarController>();

  ValueNotifier<ClientStatus> _status = ValueNotifier(ClientStatus.starting);

  Client(CookieJar cookieJar) {

    dio = Dio()
      ..options.baseUrl = Utils.SERVER_ADDRESS
      ..options.sendTimeout = 5000
      ..options.receiveTimeout = 5000
      ..options.connectTimeout = 5000
      ..interceptors.add(CookieManager(cookieJar));
  }

  void addStatusListener(void Function(ClientStatus status) f) {
    _status.addListener(() {
      f(_status.value);
    });
  }

  Future<Either<Failure, Unit>> signUp(String username, String password) async {
    Response resp;
    try {
      resp = await dio.post(
        '/user/register',
        data: 'username=$username&password=$password',
        options: Options(headers: {
          Headers.contentTypeHeader: 'application/x-www-form-urlencoded',
        }),
      );
    } on DioError catch (e) {
      _status.value = ClientStatus.connectionError;
      return Left(Failure(
        type: FailureType.noConnection,
        message: Some('Connection problems'),
      ));
    } catch (e) {
      print("[logInWithPassword] error: $e");
      return Left(Failure.empty());
    }

    Map<String, dynamic> respData = resp.data;
    bool success = respData['status'] == 'success';

    if (success) _status.value = ClientStatus.loggedIn;
    return Right(unit);
  }

  /// Makes a log in request to the server. Sets the status to [ClientStatus.loggedIn] in case of
  /// success;
  Future<Either<Failure, Unit>> logInWithPassword(String username, String password) async {
    Response resp;
    try {
      resp = await dio.post(
        '/user/login',
        data: 'username=$username&password=$password',
        options: Options(headers: {
          Headers.contentTypeHeader: 'application/x-www-form-urlencoded',
        }),
      );
    } on DioError catch (e) {
      _status.value = ClientStatus.connectionError;
      return Left(Failure(
        type: FailureType.noConnection,
        message: Some("Couldn't perform the request"),
      ));
    } catch (e) {
      print("[logInWithPassword] error: $e");
      return Left(Failure.empty());
    }

    Map<String, dynamic> respData = resp.data;
    bool success = respData['status'] == 'success';

    if (success) {
      _status.value = ClientStatus.loggedIn;

      return Right(unit);
    } else {
      return Left(Failure(
        type: FailureType.logInIncorrectCredentials,
        message: Some('Incorrect username or password'),
      ));
    }
  }

  /// If there is a token, makes a request to verify it. Sets the status to [ClientStatus.loggedIn]
  /// in case of success;
  Future<Either<Failure, Unit>> logInWithToken() async {
    Response resp;
    try {
      resp = await dio.get('/user/tokencheck');
    } on DioError catch (e) {
      _status.value = ClientStatus.connectionError;
      return Left(Failure(
        type: FailureType.noConnection,
        message: Some("Couldn't connect"),
      ));
    } catch (e) {
      print("[logInWithPassword] error: $e");
      return Left(Failure.empty());
    }

    Map<String, dynamic> respData = resp.data;
    print('log in with token. Response: $respData');
    bool success = respData['valid'] == 1;

    if (success) {
      _status.value = ClientStatus.loggedIn;
    } else {
      _status.value = ClientStatus.loggedOut;
    }

    return Right(unit);
  }

  /// Tries to reconnect to the server repeateadly every second until succeeds.
  void tryReconnect() async {
    while (true) {
      print("[Client.dart] reconnecting");
      final res = await logInWithToken();
      await Future.delayed(Duration(milliseconds: 1000));
      if (res.isRight()) {
        _flashbar.send(Failure.any('Connection restored'));
        return;
      }
    }
  }

  void logOut() {
    _status.value = ClientStatus.loggedOut;
  }
}
