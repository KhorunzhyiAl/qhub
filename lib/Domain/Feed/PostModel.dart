import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:qhub/Domain/Feed/Post.dart';
import 'package:dartz/dartz.dart';

/// Represents a post and provides a way to interact with it.
class PostModel extends ChangeNotifier {
  Option<Option<Post>> _post;
  final String _id;

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
    _load(id).then((value) {
      _post = Some(value);
      notifyListeners();
    });
  }

  Future<bool> upvote() async {
    return true;
  }

  Future<bool> downvote() async {
    return true;
  }

  Future<void> update() async {
    _post = Some(await _load(_id));
    notifyListeners();
  }

  /// Loads post with the given [id]. If fails (the post doesn't exist), completes with None();
  static Future<Option<Post>> _load(String id) async {
    final result = Post(
      id: id,
      title:
          """Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam""",
      body:
          """Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source. Lorem Ipsum comes from sections 1.10.32 and 1.10.33 of "de Finibus Bonorum et Malorum" (The Extremes of Good and Evil) by Cicero, written in 45 BC. This book is a treatise on the theory of ethics, very popular during the Renaissance. The first line of Lorem Ipsum, "Lorem ipsum dolor sit amet..", comes from a line in section 1.10.32.

The standard chunk of Lorem Ipsum used since the 1500s is reproduced below for those interested. Sections 1.10.32 and 1.10.33 from "de Finibus Bonorum et Malorum" by Cicero are also reproduced in their exact original form, accompanied by English versions from the 1914 translation by H. Rackham.
""",
      author: 'author',
      upvotes: 10,
      downvotes: 2,
      community: 'hubname',
      imageUri: Some('imageid'),
    );

    return Some(result);
  }
}
