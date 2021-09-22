import 'dart:io';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qhub/Domain/Core/Client/Client.dart';
import 'package:qhub/Domain/Core/FlashbarController.dart';
import 'package:qhub/Domain/Core/Storage.dart';
import 'package:qhub/Domain/Navigation/RouteGenerator.dart';
import 'package:qhub/Config/MyTheme.dart';
import 'package:qhub/Domain/Navigation/Routes.dart';
import 'package:qhub/Screens/Widgets/Flashbar/Flashbar.dart';
import 'package:qhub/Domain/Locators.dart';

void main(List<String> args) async {
  initStorage();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  final navKey = GlobalKey<NavigatorState>();

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool loaded = false;
  final theme = MyTheme();

  @override
  void initState() {
    super.initState();

    locator.registerSingleton<FlashbarController>(FlashbarController());
    locator.registerSingleton<MyTheme>(theme);
    initClient();
  }

  void initClient() async {
    final appDocDir = await getApplicationDocumentsDirectory();
    final cookieJar = PersistCookieJar(storage: FileStorage(appDocDir.path + '/cookies'));
    Client cli = Client(cookieJar);

    locator.registerSingleton<Client>(cli);

    cli.addStatusListener((status) async {
      switch (status) {
        case ClientStatus.loggedIn:
          widget.navKey.currentState?.pushNamedAndRemoveUntil(Routes.feed, (route) => false);
          break;
        case ClientStatus.loggedOut:
          widget.navKey.currentState?.pushNamedAndRemoveUntil(Routes.logIn, (route) => false);
          break;
        case ClientStatus.connectionError:
          cli.tryReconnect();
          break;
        default:
          break;
      }
    });

    cli.logInWithToken();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: theme,
      builder: (context, child) {
        return MaterialApp(
          theme: theme.currentTheme,
          themeMode: theme.currentThemeMode,
          initialRoute: Routes.splash,
          navigatorKey: widget.navKey,
          onGenerateRoute: RouteGenerator.generateRoute,
          builder: (context, child) {
            if (child == null) return SizedBox.shrink();

            return Stack(
              children: [
                child,
                Flashbar(locator<FlashbarController>()),
              ],
            );
          },
        );
      },
    );
  }
}
