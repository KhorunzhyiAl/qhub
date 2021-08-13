import 'package:flutter/material.dart';
import 'package:qhub/Domain/Models/PostModel.dart';

class PostViewLandscape extends StatelessWidget {
  final PostModel _postModel;

  PostViewLandscape(this._postModel);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final post = _postModel.post!;

    return Container(
      height: 200,
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          if (post.imageUri != null)
            Container(
              alignment: Alignment.topCenter,
              width: 200,
              height: 200,
              child: Image.network(
                '',
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
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text(post.title, style: theme.textTheme.headline2),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
