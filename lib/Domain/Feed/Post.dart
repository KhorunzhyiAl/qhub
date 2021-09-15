import 'package:dartz/dartz.dart';

class Post {
  final String id;
  final String title;
  final String body;
  final String author;
  final int upvotes;
  final int downvotes;
  final String community;
  final Option<String> imageUri;

  Post({
    required this.id,
    required this.title,
    required this.body,
    required this.author,
    required this.upvotes,
    required this.downvotes,
    required this.community,
    this.imageUri = const None(),
  });

  Post.empty()
      : id = '',
        title = '',
        body = '',
        author = '',
        upvotes = 0,
        downvotes = 0,
        community = '',
        imageUri = None();
}

