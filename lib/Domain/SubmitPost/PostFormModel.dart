import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:qhub/Domain/Core/Failure.dart';
import 'package:qhub/Domain/Core/FlashbarController.dart';
import 'package:qhub/Domain/Feed/Post.dart';
import 'package:qhub/Domain/Locators.dart';
import 'package:qhub/Domain/Core/Api.dart';

/// Model for creating or editing a post. Provides validators for input
class PostFormModel {
  final _titleErrorNotifier = ValueNotifier<Option<String>>(None());
  ValueListenable<Option<String>> get titleError => _titleErrorNotifier;
  final popup = locator<FlashbarController>();

  final ValueNotifier<Option<String>> community;
  final ValueNotifier<Option<String>> imagePath;
  final ValueNotifier<String> title;
  final ValueNotifier<String> body;

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

  /// Attempts to submit the post and completes with its id.
  Future<Option<String>> submit() async {
    final res = await submitPost(
      community: community.value.fold(() => '', (a) => a),
      title: title.value,
      body: body.value,
    );

    return res.fold(
      (l) {
        if (l.type == FailureType.submitPostTitleEmpty) {
          _titleErrorNotifier.value = l.message;
          return None();
        }
        popup.send(l);
        return None();
      },
      (r) => Some(r),
    );
  }
}
