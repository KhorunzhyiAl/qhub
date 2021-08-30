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
          print('user avatar error builder');
          return Container(
            color: Colors.grey,
            child: Icon(Icons.person, color: Colors.white),
          );
        },
      ),
    );
  }
}
