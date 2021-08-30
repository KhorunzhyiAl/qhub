import 'package:flutter/material.dart';
import 'package:qhub/Domain/Feed/PostModel.dart';
import 'package:qhub/Domain/Feed/Post.dart';
import 'package:qhub/Screens/Widgets/PostWidget/Utils/PostWidgetPortrait.dart';
import 'package:qhub/Screens/Widgets/PostWidget/Utils/PostWidgetLandscape.dart';

class PostWidget extends StatelessWidget {
  final PostModel _postModel;

  PostWidget(Post post) : _postModel = PostModel(post);

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;

    switch (orientation) {
      case Orientation.portrait:
        return PostViewPortrait(_postModel);
      case Orientation.landscape:
        return PostViewLandscape(_postModel);
    }
  }
}

