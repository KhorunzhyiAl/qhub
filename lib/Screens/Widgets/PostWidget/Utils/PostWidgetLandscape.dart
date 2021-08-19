import 'package:flutter/material.dart';
import 'dart:math';

import 'package:qhub/Domain/Models/PostModel.dart';
import 'package:qhub/Screens/Widgets/UsernameLabel.dart';

class PostViewLandscape extends StatelessWidget {
  final PostModel _postModel;

  PostViewLandscape(this._postModel);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final post = _postModel.post!;

    return Material(
      color: theme.colorScheme.background,
      child: InkWell(
        onTap: () {},
        child: Container(
          height: 150,
          padding: EdgeInsets.symmetric(horizontal: 10),
          color: Colors.transparent,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              if (post.imageUri != null)
                AspectRatio(
                  aspectRatio: 1,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(3),
                    child: Image.network(
                      'https://picsum.photos/600',
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) {
                        return Container(
                          color: Colors.blue,
                          child: Center(
                            child: Text(':('),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              SizedBox(width: 10),
              Expanded(
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Text(
                        post.title.substring(0, min(post.title.length, 300)),
                        style: theme.textTheme.headline5,
                      ),
                      Spacer(),
                      Container(
                        color: Colors.transparent,
                        height: 40,
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
            ],
          ),
        ),
      ),
    );
  }
}
