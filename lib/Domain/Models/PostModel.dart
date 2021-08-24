import 'package:flutter/cupertino.dart';
import 'package:qhub/Domain/Elements/Post.dart';
import 'package:qhub/Domain/Service/PostService.dart';

class PostModel extends ChangeNotifier {
  PostService _service;

  PostModel(Post post) : _service = PostService.existing(post);

  Post get post {
    if (_service.post == null) {
      return Post.unknown();
    }
    return _service.post!;
  }

  Future<void> update() async {
    await _service.update();
    notifyListeners();
  }

  Future<bool> upvote() async {
    return true;
  }
  Future<bool> downvote() async {
    return true;
  }
}
