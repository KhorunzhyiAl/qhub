import 'package:qhub/Domain/Elements/Post.dart';

class Feed {
  Stream<Post> posts;
  String name;

  Feed({
    required this.name,
    required this.posts,
  });
}

class FeedOptions {
  final String name;

  FeedOptions({
    required this.name,
  });
}
