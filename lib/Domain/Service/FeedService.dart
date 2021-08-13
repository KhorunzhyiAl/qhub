import 'dart:async';

import 'package:qhub/Domain/Service/Client.dart';
import 'package:qhub/Domain/Locators.dart';
import 'package:qhub/Domain/Elements/Feed.dart';
import 'package:qhub/Domain/Elements/Post.dart';

class FeedService {
  final _dio = locator<Client>().dio;
  final _postsController = StreamController<Post>();

  late final Feed feed;

  FeedService(FeedIdentifier parameters) {
    feed = Feed(
      parameters: parameters,
      posts: _postsController.stream,
    );
  }

  /// Starts loading next [n] posts and returns true if no error occurred.
  ///
  /// First, performs a request to the server to get a [Response] containing the posts, then as it
  /// converts the data to [Post]s, adds them one by one to the stream - [feed.posts].
  /// 
  /// TODO: In case of an error: add it to the stream, throw or return?
  Future<void> loadNext([int n = 100]) async {
    print('loading $n more posts');
    for (int i = 0; i < n; ++i) {
      _postsController.add(Post(
          id: '1234',
          title: 'title $i text text text text text text text text text text text text text text text text text ',
          body: 'body',
          author: 'author',
          imageUri: 'imageIdHere',
          upvotes: 10,
          downvotes: 5,
          hubName: 'hubname'));
    }
  }
}
