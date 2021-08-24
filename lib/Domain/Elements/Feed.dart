import 'package:qhub/Domain/Elements/Post.dart';

class Feed {
  FeedIdentifier parameters;
  Stream<Post> posts;

  Feed({
    required this.parameters,
    required this.posts,
  });
}

/// All infromation needed to uniquely identify a feed, e.g. hub name, search parameters, etc.
class FeedIdentifier {
  final String? hubName;

  FeedIdentifier({
    this.hubName,
  });
}
