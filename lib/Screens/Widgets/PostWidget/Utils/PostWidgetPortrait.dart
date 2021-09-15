import 'package:flutter/material.dart';
import 'package:qhub/Domain/Feed/Post.dart';

import 'package:qhub/Domain/Feed/PostModel.dart';
import 'package:qhub/Domain/Navigation/Routes.dart';
import 'package:qhub/Domain/Utils.dart';
import 'package:qhub/Screens/Widgets/PostInfo.dart';

class PostViewPortrait extends StatelessWidget {
  final PostModel _postModel;

  PostViewPortrait(this._postModel);

  @override
  Widget build(BuildContext context) {
    return Card(
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
          'Failed to load the post',
          style: theme.textTheme.headline3,
        ),
      ),
    );
  }

  Widget _loadedPost(BuildContext context, Post postData) {
    final theme = Theme.of(context);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          if (postData.imageUri.isSome()) ...[
            AspectRatio(
              aspectRatio: 5 / 3,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(2),
                child: Image.network(
                  postData.imageUri.fold(() => '', (a) => Utils.createImageUrl(a)),
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
          ],
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(postData.title, style: theme.textTheme.headline3),
                SizedBox(height: 10),
                PostInfo(postModel: _postModel),
                SizedBox(height: 10),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
