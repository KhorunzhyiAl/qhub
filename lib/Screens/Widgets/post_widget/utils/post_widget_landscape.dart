import 'package:flutter/material.dart';
import 'dart:math';

import 'package:qhub/domain/feed/post.dart';
import 'package:qhub/domain/feed/post_model.dart';
import 'package:qhub/domain/navigation/routes.dart';
import 'package:qhub/domain/utils.dart';
import 'package:qhub/screens/widgets/post_info.dart';

class PostViewLandscape extends StatelessWidget {
  final PostModel _postModel;

  PostViewLandscape(this._postModel);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 600,
      child: Card(
        child: InkWell(
          onTap: () {
            Navigator.of(context).pushNamed(Routes.post, arguments: _postModel);
          },
          child: AnimatedBuilder(
            animation: _postModel,
            builder: (context, child) {
              return _postModel.post.fold(
                () => _loading(context),
                (loaded) => loaded.fold(
                  () => _loadedNone(context),
                  (postData) => _loadedPost(context, postData),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _loading(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      color: Colors.transparent,
      child: Center(
        child: CircularProgressIndicator(
          color: theme.colorScheme.onBackground,
          backgroundColor: Colors.transparent,
        ),
      ),
    );
  }

  Widget _loadedNone(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      color: Colors.transparent,
      child: Center(
        child: Text(
          'Failed to load post',
          style: theme.textTheme.headline3,
        ),
      ),
    );
  }

  Widget _loadedPost(BuildContext context, Post postData) {
    final theme = Theme.of(context);

    return Container(
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
                  postData.title.substring(0, min(postData.title.length, 300)) +
                      (postData.title.length >= 300 ? '...' : ''),
                  style: theme.textTheme.headline3,
                ),
              ),
              SizedBox(width: 40),
              postData.imageUri.fold(
                () => SizedBox.shrink(),
                (a) => LimitedBox(
                  maxHeight: 100,
                  child: AspectRatio(
                    aspectRatio: 4 / 3,
                    child: Hero(
                      tag: a,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(2),
                        child: Image.network(
                          Utils.createImageUrl(a),
                          fit: BoxFit.cover,
                          frameBuilder: (_, child, __, ___) {
                            return child;
                          },
                          loadingBuilder: (_, child, chunk) {
                            return Container(
                              color: Colors.grey,
                              child: child,
                            );
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
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          PostInfo(postModel: _postModel),
        ],
      ),
    );
  }
}
