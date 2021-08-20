import 'dart:async';
import 'dart:math';

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
    final rand = Random.secure();

    for (int i = 0; i < n; ++i) {
      _postsController.add(Post(
        id: '$i',
        title:
            """Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam""",
        body:
            """Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source. Lorem Ipsum comes from sections 1.10.32 and 1.10.33 of "de Finibus Bonorum et Malorum" (The Extremes of Good and Evil) by Cicero, written in 45 BC. This book is a treatise on the theory of ethics, very popular during the Renaissance. The first line of Lorem Ipsum, "Lorem ipsum dolor sit amet..", comes from a line in section 1.10.32.

The standard chunk of Lorem Ipsum used since the 1500s is reproduced below for those interested. Sections 1.10.32 and 1.10.33 from "de Finibus Bonorum et Malorum" by Cicero are also reproduced in their exact original form, accompanied by English versions from the 1914 translation by H. Rackham.
""",
        author: 'author',
        upvotes: 10,
        downvotes: 2,
        hubName: 'hubname',
        imageUri: rand.nextBool() ? null : 'imageid',
      ));
    }
  }
}
