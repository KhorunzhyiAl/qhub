import 'package:flutter/material.dart';
import 'package:qhub/domain/feed/post_model.dart';
import 'package:qhub/domain/feed/post.dart';
import 'package:qhub/screens/widgets/post_widget/utils/post_widget_portrait.dart';
import 'package:qhub/screens/widgets/post_widget/utils/post_widget_landscape.dart';

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

