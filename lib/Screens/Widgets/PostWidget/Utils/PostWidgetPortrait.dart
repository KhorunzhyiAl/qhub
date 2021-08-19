import 'package:flutter/material.dart';

import 'package:qhub/Domain/Models/PostModel.dart';
import 'package:qhub/Screens/Widgets/UsernameLabel.dart';

class PostViewPortrait extends StatelessWidget {
  final PostModel _postModel;

  PostViewPortrait(this._postModel);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final post = _postModel.post!;

    return Material(
      color: theme.colorScheme.background,
      child: InkWell(
        onTap: () {},
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              if (post.imageUri != null)
                AspectRatio(
                  aspectRatio: 5 / 3,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(3),
                    child: Image.network(
                      'https://picsum.photos/700',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              Text(post.title, style: theme.textTheme.headline5),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 0, vertical: 5),
                color: Colors.transparent,
                height: 60,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    UsernameLabel(username: post.author),
                    SizedBox(width: 10),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
