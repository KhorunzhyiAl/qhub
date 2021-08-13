import 'package:flutter/material.dart';
import 'package:qhub/Domain/Elements/Feed.dart';
import 'package:qhub/Domain/Models/FeedModel.dart';
import 'package:qhub/Screens/Home/Widgets/PostListWidget.dart';

class HomeScreen extends StatelessWidget {
  final _feedModel = FeedModel(FeedIdentifier(hubName: 'home'))..loadMore();

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        shadowColor: theme.shadowColor,
        backgroundColor: theme.colorScheme.primary,
        leading: Container(
          alignment: Alignment.center,
          child: IconButton(
            onPressed: () {},
            icon: Icon(Icons.menu),
            color: theme.colorScheme.onPrimary,
          ),
        ),
        title: Text(
          _feedModel.feedParameters.hubName,
          style: theme.textTheme.headline1,
        ),
      ),
      body: Container(
        color: theme.colorScheme.background,
        child: PostListWidget(_feedModel),
      ),
    );
  }
}
