import 'package:qhub/Domain/Elements/Post.dart';

class Feed {
  FeedParameters parameters;
  Stream<Post> posts;

  Feed({
    required this.parameters,
    required this.posts,
  });
}

/// All infromation needed to uniquely identify a feed, e.g. hub name, search parameters, etc.
class FeedParameters {
  final String hubName;

  FeedParameters({
    required this.hubName,
  });
}
