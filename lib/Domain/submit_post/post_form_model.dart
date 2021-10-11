import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:qhub/domain/core/failure.dart';
import 'package:qhub/domain/core/flashbar_controller.dart';
import 'package:qhub/domain/feed/post.dart';
import 'package:qhub/domain/locators.dart';
import 'package:qhub/domain/core/api.dart';
import 'package:qhub/domain/submit_post/upload_image_model.dart';

/// Model for creating or editing a post. Provides validators for input
class PostFormModel {
  final _titleErrorNotifier = ValueNotifier<Option<String>>(None());
  final _popup = locator<FlashbarController>();


  final ValueNotifier<Option<String>> community;
  final ValueNotifier<String> title;
  final ValueNotifier<String> body;
  final imageUploader = UploadImageModel();

  ValueListenable<Option<String>> get titleError => _titleErrorNotifier;

  PostFormModel({Option<String> community = const None()})
      : community = ValueNotifier(community),
        title = ValueNotifier(''),
        body = ValueNotifier('');

  /// Constructs a model for editing an existing post. Verifies if the post is editable (user is the
  /// author)
  PostFormModel.edit(Post post)
      : community = ValueNotifier(Some(post.community)),
        title = ValueNotifier(post.title),
        body = ValueNotifier(post.body);

  /// Completes with the id of the post if succeeded.
  Future<Option<String>> submit() async {
    if (imageUploader.uploadStatus.value == UploadImageStatus.uploading) {
      _popup.send(Failure(type: FailureType.any, message: Some('Image is still being uploaded')));
      return None();
    }

    final res = await submitPost(
      community: community.value.fold(() => '', (a) => a),
      title: title.value,
      body: body.value,
      imageUri: imageUploader.uploadedImageUri.fold(() => '', (a) => a),
    );

    return res.fold(
      (l) {
        if (l.type == FailureType.submitPostTitleEmpty) {
          _titleErrorNotifier.value = l.message;
          return None();
        }
        _popup.send(l);
        return None();
      },
      (r) => Some(r),
    );
  }

  void _initListeners() {}
}
