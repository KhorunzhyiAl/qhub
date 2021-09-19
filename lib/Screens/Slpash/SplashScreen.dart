import 'package:cookie_jar/cookie_jar.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qhub/Domain/Core/Client/Client.dart';
import 'package:qhub/Domain/Locators.dart';
import 'package:qhub/Domain/Navigation/Routes.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    initClient();
  }

  void initClient() async {
    final appDocDir = await getApplicationDocumentsDirectory();
    final cookieJar = PersistCookieJar(storage: FileStorage(appDocDir.path + '/cookies'));
    Client cli = Client(cookieJar);

    locator.registerSingleton<Client>(cli);

    final nav = Navigator.of(context);
    cli.addStatusListener((status) async {
      switch (status) {
        case ClientStatus.loggedIn:
          nav.pushNamedAndRemoveUntil(Routes.feed, (route) => false);
          break;
        case ClientStatus.loggedOut:
          nav.pushNamedAndRemoveUntil(Routes.logIn, (route) => false);
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
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(
        child: Container(
          color: Colors.transparent,
          width: 150,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                height: 100,
                child: FittedBox(
                  fit: BoxFit.contain,
                  child: Text('qhɥb', style: theme.textTheme.headline1),
                ),
              ),
              LinearProgressIndicator(
                  minHeight: 40, color: Colors.black, backgroundColor: Colors.transparent),
            ],
          ),
        ),
      ),
    );
  }
}
