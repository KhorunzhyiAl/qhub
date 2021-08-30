import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:qhub/Domain/Feed/Post.dart';
import 'package:qhub/Domain/Feed/PostModel.dart';
import 'package:qhub/Screens/Widgets/UserAvatar.dart';
import 'package:qhub/Screens/Widgets/UserLabel.dart';

class PostInfo extends StatelessWidget {
  final PostModel postModel;

  PostInfo({required this.postModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      child: AnimatedBuilder(
        animation: postModel,
        builder: (context, child) {
          return postModel.post.fold(
            () => _loading(context),
            (loaded) => loaded.fold(
              () => _loadedNone(context),
              (postData) => _loadedPost(context, postData),
            ),
          );
        },
      ),
    );
  }

  Widget _loading(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      height: 30,
      width: 100,
      color: theme.colorScheme.onBackground.withAlpha(20),
    );
  }

  Widget _loadedNone(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      height: 30,
      width: 100,
      color: theme.colorScheme.onBackground.withAlpha(20),
    );
  }

  Widget _loadedPost(BuildContext context, Post postData) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        UserLabel(username: postData.author),
      ],
    );
  }
}
