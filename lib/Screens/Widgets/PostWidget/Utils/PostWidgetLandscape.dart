import 'package:flutter/material.dart';
import 'dart:math';

import 'package:qhub/Domain/Models/PostModel.dart';
import 'package:qhub/Screens/Widgets/UsernameLabel.dart';
import 'package:qhub/Domain/Navigation/Routes.dart';
import 'package:qhub/Screens/Widgets/PostInfo.dart';

class PostViewLandscape extends StatelessWidget {
  final PostModel _postModel;

  PostViewLandscape(this._postModel);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Material(
      color: theme.colorScheme.background,
      child: InkWell(
        onTap: () {
          Navigator.of(context).pushNamed(Routes.post, arguments: _postModel);
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
          color: Colors.transparent,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              if (_postModel.post.imageUri != null)
                LimitedBox(
                  maxHeight: 100,
                  child: AspectRatio(
                    aspectRatio: 4/3,
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
                ),
              SizedBox(width: 20),
              Container(
                width: 400,
                color: Colors.transparent,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Text(
                      _postModel.post.title.substring(0, min(_postModel.post.title.length, 300)),
                      style: theme.textTheme.headline5,
                    ),
                    SizedBox(height: 30),
                    PostInfo(postModel: _postModel),
                  ],
                ),
              ),
              SizedBox(width: 70),
            ],
          ),
        ),
      ),
    );
  }
}
