import 'package:qhub/Domain/Elements/Post.dart';
import 'package:qhub/Domain/Service/PostService.dart';


class PostModel {
  PostService _service;

  PostModel(Post post) : _service = PostService.existing(post);

  Post? get post => _service.post;

  Future<void> update() async {
    _service.update();
  }
}
