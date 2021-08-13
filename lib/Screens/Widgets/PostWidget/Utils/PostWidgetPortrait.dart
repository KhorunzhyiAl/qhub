import 'package:flutter/material.dart';
import 'package:qhub/Domain/Models/PostModel.dart';

class PostViewPortrait extends StatelessWidget {
  final PostModel _postModel;

  PostViewPortrait(this._postModel);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final post = _postModel.post!;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          if (post.imageUri != null)
            AspectRatio(
              aspectRatio: 5 / 3,
              child: Image.network(''),
            ),
          Text(post.title, style: theme.textTheme.headline2),
          Text(post.body, style: theme.textTheme.bodyText2),
        ],
      ),
    );
  }
}
