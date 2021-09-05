import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:qhub/Domain/Core/Failure.dart';
import 'package:qhub/Domain/Core/FlashbarController.dart';
import 'package:qhub/Domain/Navigation/RouteGenerator.dart';
import 'package:qhub/Config/MyTheme.dart';
import 'package:qhub/Domain/Navigation/Routes.dart';
import 'package:qhub/Domain/Core/Client/Client.dart';
import 'package:qhub/Domain/Locators.dart';
import 'package:qhub/Screens/Widgets/Flashbar/Flashbar.dart';

late final Future<Either<Failure, Unit>> _loggedIn;
String _initialRoute = Routes.splash;

void main() {
  initLocator();

  // Run logInWithToken as early as possible (while the UI is still loading).
  // - if completes with *success* before the UI is loaded, set [_initialRoute] to Feed screen;
  // - if completes with *failure* before the UI is loaded, set [_initialRoute] to logIn screen;
  // - if the UI loads first, the value of [_initialRoute] doesn't matter and the screen is selected
  //   the normal way, by listening to client status ([Client.addStatusListener]).
  final service = locator<Client>();
  _loggedIn = service.logInWithToken();
  _loggedIn.then((value) {
    value.fold(
      (l) {
        _initialRoute = Routes.feed;
      },
      (r) {
        _initialRoute = Routes.feed;
      },
    );
  });

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final navKey = GlobalKey<NavigatorState>();
    final theme = MyTheme();
    final client = locator<Client>();

    client.addStatusListener((status) {
      switch (status) {
        case ClientStatus.loggedIn:
          _initialRoute = Routes.feed; // Used only for hot reload, can be removed later
          navKey.currentState?.pushNamedAndRemoveUntil(Routes.feed, (route) => false);
          break;
        case ClientStatus.loggedOut:
          _initialRoute = Routes.logIn;
          navKey.currentState?.pushNamedAndRemoveUntil(Routes.logIn, (route) => false);
          break;
        case ClientStatus.connectionError:
          _initialRoute = Routes.error;
          navKey.currentState?.pushNamedAndRemoveUntil(
            Routes.error,
            (route) => false,
            arguments: 'Problems connecting to the server',
          );
          break;
        case ClientStatus.starting:
          _initialRoute = Routes.splash;
          break;
      }
    });

    print('initial route = $_initialRoute');
    return MaterialApp(
      theme: theme.currentTheme,
      themeMode: theme.currentMode,
      initialRoute: _initialRoute,
      navigatorKey: navKey,
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
  }
}
