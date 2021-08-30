class Post {
  final String id;
  final String title;
  final String body;
  final String author;
  final int upvotes;
  final int downvotes;
  final String hubName;
  final String? imageUri;

  Post({
    required this.id,
    required this.title,
    required this.body,
    required this.author,
    required this.upvotes,
    required this.downvotes,
    required this.hubName,
    this.imageUri,
  });
}
