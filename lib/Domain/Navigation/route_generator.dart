import 'package:flutter/material.dart';

import 'package:qhub/domain/submit_post/post_form_model.dart';
import 'package:qhub/domain/feed/post_model.dart';
import 'package:qhub/screens/select_feed/select_feed_screen.dart';
import 'package:qhub/screens/splash/splash_screen.dart';
import 'package:qhub/screens/log_in/log_in_screen.dart';
import 'package:qhub/screens/sign_up/sign_up_screen.dart';
import 'package:qhub/screens/error/error_screen.dart';
import 'package:qhub/domain/navigation/routes.dart';
import 'package:qhub/screens/feed/feed_screen.dart';
import 'package:qhub/screens/post/post_screen.dart';
import 'package:qhub/screens/create_post/create_post_screen.dart';
import 'package:qhub/domain/feed/feed_query.dart';

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
        return MaterialPageRoute<FeedQuery>(builder: (_) => SelectHubScreen());
      default:
        screen = ErrorScreen(message: "Route '${settings.name}' doesn't exist");
    }

    return MaterialPageRoute(builder: (context) {
      return screen;
    });
  }
}
