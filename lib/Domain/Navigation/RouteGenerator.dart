import 'package:flutter/material.dart';
import 'package:qhub/Domain/Elements/Feed.dart';

import 'package:qhub/Domain/Models/PostFormModel.dart';
import 'package:qhub/Domain/Models/PostModel.dart';
import 'package:qhub/Screens/SelectFeedScreen/SelectFeedScreen.dart';
import 'package:qhub/Screens/Slpash/SplashScreen.dart';
import 'package:qhub/Screens/login/LogInScreen.dart';
import 'package:qhub/Screens/signup/SignUpScreen.dart';
import 'package:qhub/Screens/error/ErrorScreen.dart';
import 'package:qhub/Domain/Navigation/Routes.dart';
import 'package:qhub/Screens/Feed/FeedScreen.dart';
import 'package:qhub/Screens/Post/PostScreen.dart';
import 'package:qhub/Screens/CreatePostScreen/CreatePostScreen.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final Widget screen;

    switch (settings.name) {
      case Routes.splash:
        screen = SplashScreen();
        break;
      case Routes.logIn:
        screen = LogInScreen();
        break;
      case Routes.signUp:
        screen = SignUpScreen();
        break;
      case Routes.feed:
        screen = FeedScreen();
        break;
      case Routes.error:
        screen = ErrorScreen(message: settings.arguments as String);
        break;
      case Routes.post:
        screen = PostScreen(postModel: settings.arguments as PostModel);
        break;
      case Routes.createPost:
        screen = CreatePostScreen(postFormModel: settings.arguments as PostFormModel);
        break;
      case Routes.selectFeed:
        return MaterialPageRoute<FeedParameters>(builder: (_) => SelectHubScreen());
      default:
        screen = ErrorScreen(message: "Route '${settings.name}' doesn't exist");
    }

    return MaterialPageRoute(builder: (context) {
      return screen;
    });
  }
}
