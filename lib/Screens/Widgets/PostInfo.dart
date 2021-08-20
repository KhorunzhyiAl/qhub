import 'package:flutter/material.dart';
import 'package:qhub/Domain/Models/PostModel.dart';
import 'package:qhub/Screens/Widgets/UserLabel.dart';

class PostInfo extends StatelessWidget {
  final PostModel postModel;

  PostInfo({required this.postModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          UserLabel(username: postModel.post.author),
          SizedBox(width: 15),
        ],
      ),
    );
  }
}
