import 'dart:async';

import 'package:qhub/Domain/Elements/Feed.dart';
import 'package:qhub/Domain/Elements/Post.dart';

class FeedService {
  final _postsController = StreamController<Post>();
  late final Feed _feed;
  final FeedOptions options;

  FeedService(this.options) {
    Feed(
      name: options.name,
      posts: _postsController.stream,
    );
  }

  Future<bool> loadNext(int n) async {
    return false;
  }
}
