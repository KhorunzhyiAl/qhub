import 'package:flutter/material.dart';
import 'package:qhub/Domain/Models/PostModel.dart';
import 'package:qhub/Domain/Elements/Post.dart';
import 'package:qhub/Screens/Widgets/PostWidget/Utils/PostWidgetPortrait.dart';
import 'package:qhub/Screens/Widgets/PostWidget/Utils/PostWidgetLandscape.dart';

class PostWidget extends StatelessWidget {
  final PostModel _postModel;

  PostWidget(Post post) : _postModel = PostModel(post);

  @override
  Widget build(BuildContext context) {
    if (!_postModel.post.loaded) {
      return _LoadingPostView();
    }

    final orientation = MediaQuery.of(context).orientation;

    switch (orientation) {
      case Orientation.portrait:
        return PostViewPortrait(_postModel);
      case Orientation.landscape:
        return PostViewLandscape(_postModel);
    }
  }
}

class _LoadingPostView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
