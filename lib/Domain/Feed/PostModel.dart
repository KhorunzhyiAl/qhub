import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:qhub/Domain/Core/Api.dart';
import 'package:qhub/Domain/Core/FlashbarController.dart';
import 'package:qhub/Domain/Feed/Post.dart';
import 'package:dartz/dartz.dart';
import 'package:qhub/Domain/Locators.dart';
import 'package:qhub/Domain/Core/Api.dart' as api;

/// Represents a post and provides a way to interact with it.
class PostModel extends ChangeNotifier {
  Option<Option<Post>> _post;
  final String _id;
  final _flashbar = locator<FlashbarController>();

  /// (this is either shitcode, or a pretty good idea)
  /// Do something like this:
  ///
  /// ```
  /// .fold(
  ///   () => /* post is still loading */,
  ///   (e) => e.fold(
  ///     () => /* loading finished with error (like incorrect id) */,
  ///     (e) => /* loading finished and the post is ready */,
  ///   )
  /// )
  /// ```
  ///
  /// Listeners are notified when this value changes.
  ///
  /// After loading for the first time, the post will never be in the loading state again. After
  /// calling [update], this field keeps the old value until the new data arrives.
  Option<Option<Post>> get post {
    return _post;
  }

  PostModel(Post post)
      : _post = Some(Some(post)),
        _id = post.id;

  PostModel.load(String id)
      : _post = None(),
        _id = id {
    update();
  }

  Future<bool> upvote() async {
    // First change the data locally and noify, so that user sees the result instantly.
    _post = _post.fold(
      () => _post,
      (a) => a.fold(
        () => _post,
        (a) => Some(Some(a.upvoted())),
      ),
    );
    notifyListeners();

    // Then, when the request finished, update the values according to the server (to show the
    // relevant info even if the upvote didn't count for some reason).
    final res = await api.upvotePost(_id);
    update();
    return res;
  }

  Future<bool> downvote() async {
    // First change the data locally and noify, so that user sees the result instantly.
    _post = _post.fold(
      () => _post,
      (a) => a.fold(
        () => _post,
        (a) => Some(Some(a.downvoted())),
      ),
    );
    notifyListeners();

    // Then, when the request finished, update the values according to the server (to show the
    // relevant info even if the upvote didn't count for some reason).
    final res = await api.upvotePost(_id);
    update();
    return res;
  }

  Future<void> update() async {
    final e = await loadPost(_id);
    e.fold(
      (l) => _flashbar.send(l),
      (r) => _post = Some(Some(r)),
    );
    notifyListeners();
  }
}
