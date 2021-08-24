import 'package:flutter/material.dart';
import 'package:qhub/Domain/Elements/Feed.dart';
import 'package:qhub/Domain/Models/FeedModel.dart';
import 'package:qhub/Domain/Models/PostFormModel.dart';
import 'package:qhub/Screens/Feed/Widgets/PostListWidget.dart';
import 'package:qhub/Screens/Widgets/FloatingButton/FloatingPopup.dart';
import 'package:qhub/Screens/Widgets/FloatingButton/Other/FloatingPopupElement.dart';
import 'package:qhub/Domain/Navigation/Routes.dart';

class FeedScreen extends StatelessWidget {
  final _feedModel = FeedModel(FeedParameters(hubName: 'home'))..loadMore();

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var nav = Navigator.of(context);

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
              message: 'home',
              icon: Icons.home,
              onPressed: () {},
            ),
            FloatingPopupElement(
              message: 'communities',
              icon: Icons.list,
              onPressed: () {},
            ),
            FloatingPopupElement(
              message: 'create post',
              icon: Icons.create,
              onPressed: () {
                nav.pushNamed(Routes.createPost,
                    arguments: PostFormModel(community: _feedModel.feedParameters.hubName));
              },
            ),
          ],
        ),
      ],
    );
  }
}
