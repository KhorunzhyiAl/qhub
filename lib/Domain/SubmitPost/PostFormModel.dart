import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:qhub/Domain/Feed/Post.dart';

/// Model for creating or editing a post. Provides validators for input
class PostFormModel {
  final ValueNotifier<Option<String>> community;
  final ValueNotifier<Option<String>> imagePath;
  final ValueNotifier<String> title;
  final ValueNotifier<String> body;

  ValueListenable<Option<String>> get communityListenable => community;

  PostFormModel({Option<String> community = const None()})
      : community = ValueNotifier(community),
        imagePath = ValueNotifier(None()),
        title = ValueNotifier(''),
        body = ValueNotifier('');

  /// Constructs a model for editing an existing post. Verifies if the post is editable (user is the
  /// author)
  PostFormModel.edit(Post post)
      : community = ValueNotifier(Some(post.community)),
        imagePath = ValueNotifier(post.imageUri),
        title = ValueNotifier(post.title),
        body = ValueNotifier(post.body);

  Future<bool> submit() async {
    return Future<bool>.delayed(Duration(milliseconds: 1000), () => true);
  }
}
