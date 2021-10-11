import 'package:flutter/material.dart';
import 'package:qhub/screens/widgets/user_avatar.dart';

class UsernameLabel extends StatelessWidget {
  final String username;

  UsernameLabel({required this.username});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      color: Colors.transparent,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          UserAvatar('https://picsum.photos/200'),
          SizedBox(width: 10),
          Text(
            username,
            style: theme.textTheme.caption,
          ),
        ],
      ),
    );
  }
}
