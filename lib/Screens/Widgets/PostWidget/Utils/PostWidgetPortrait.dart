import 'package:flutter/material.dart';

import 'package:qhub/Domain/Models/PostModel.dart';
import 'package:qhub/Screens/Widgets/UsernameLabel.dart';
import 'package:qhub/Domain/Navigation/Routes.dart';
import 'package:qhub/Screens/Widgets/PostInfo.dart';


class PostViewPortrait extends StatelessWidget {
  final PostModel _postModel;

  PostViewPortrait(this._postModel);

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
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              if (_postModel.post.imageUri != null)
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
              Text(_postModel.post.title, style: theme.textTheme.headline5),
              SizedBox(height: 10),
              PostInfo(postModel: _postModel),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
