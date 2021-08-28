import 'package:flutter/material.dart';
import 'dart:math';

import 'package:qhub/Domain/Feed/PostModel.dart';
import 'package:qhub/Domain/Navigation/Routes.dart';
import 'package:qhub/Screens/Widgets/PostInfo.dart';

class PostViewLandscape extends StatelessWidget {
  final PostModel _postModel;

  PostViewLandscape(this._postModel);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: 600,
      child: Card(
        child: InkWell(
          onTap: () {
            Navigator.of(context).pushNamed(Routes.post, arguments: _postModel);
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            color: Colors.transparent,

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        _postModel.post.title.substring(0, min(_postModel.post.title.length, 300)),
                        style: theme.textTheme.headline3,
                      ),
                    ),
                    SizedBox(width: 40),
                    if (_postModel.post.imageUri != null)
                      LimitedBox(
                        maxHeight: 100,
                        child: AspectRatio(
                          aspectRatio: 4 / 3,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(3),
                            child: Image.network(
                              'https://picsum.photos/600',
                              fit: BoxFit.cover,
                              loadingBuilder: (_, __, ___) {
                                return Container(color: Colors.grey);
                              },
                              errorBuilder: (_, __, ___) {
                                return Container(
                                  color: Colors.grey,
                                  child: Icon(Icons.image, color: Colors.white),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
                SizedBox(height: 20),
                PostInfo(postModel: _postModel),
              ],
            ),

            // ),
          ),
        ),
      ),
    );
  }
}
