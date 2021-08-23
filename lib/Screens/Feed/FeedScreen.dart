import 'package:flutter/material.dart';
import 'package:qhub/Domain/Elements/Feed.dart';
import 'package:qhub/Domain/Models/FeedModel.dart';
import 'package:qhub/Screens/Feed/Widgets/PostListWidget.dart';
import 'package:qhub/Screens/Widgets/FloatingButton/FloatingPopup.dart';
import 'package:qhub/Screens/Widgets/FloatingButton/Other/FloatingPopupElement.dart';

class FeedScreen extends StatelessWidget {
  final _feedModel = FeedModel(FeedIdentifier(hubName: 'home'))..loadMore();

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return Stack(
      children: [
        Scaffold(
          body: Container(
            color: theme.colorScheme.background,
            child: PostListWidget(
              _feedModel,
            ),
          ),
        ),
        FloatingPopup(
          options: [
            FloatingPopupElement(
              message: 'message 1',
              icon: Icons.home,
              onPressed: () {},
            ),
            FloatingPopupElement(
              message: 'message 2',
              icon: Icons.home,
              onPressed: () {},
            ),
            FloatingPopupElement(
              message: 'message 3',
              icon: Icons.home,
              onPressed: () {},
            ),
          ],
        ),
      ],
    );
  }
}
