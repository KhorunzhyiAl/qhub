import 'package:flutter/material.dart';

class UserAvatar extends StatelessWidget {
  final String imageUri;

  UserAvatar(this.imageUri);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(3),
      child: Image.network(
        imageUri,
        height: 35,
        width: 35,
      ),
    );
  }
}
