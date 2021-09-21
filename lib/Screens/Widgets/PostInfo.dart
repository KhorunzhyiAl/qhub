import 'package:flutter/material.dart';
import 'package:qhub/Domain/Feed/Post.dart';
import 'package:qhub/Domain/Feed/PostModel.dart';
import 'package:qhub/Screens/Widgets/UserLabel.dart';

class PostInfo extends StatelessWidget {
  final PostModel postModel;

  PostInfo({required this.postModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      alignment: Alignment.centerLeft,
      color: Colors.transparent,
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
    final theme = Theme.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        UserLabel(username: postData.author),
        Spacer(),
        TextButton(
          onPressed: () {
            postModel.upvote();
          },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(Icons.add, size: 18),
              Icon(Icons.add, size: 18),
              SizedBox(width: 10),
              Text(postData.upvotes.toString(), style: theme.textTheme.headline6),
            ],
          ),
        ),
        SizedBox(width: 25),
        TextButton(
          onPressed: () {
            postModel.downvote();
          },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(Icons.remove, size: 18),
              Icon(Icons.remove, size: 18),
              SizedBox(width: 10),
              Text(postData.downvotes.toString(), style: theme.textTheme.headline6),
            ],
          ),
        ),
      ],
    );
  }
}
