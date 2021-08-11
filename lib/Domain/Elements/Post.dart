

class Post {
  final String title;
  final String body;
  final String author;
  final String imageUri;
  final int upvotes;
  final int downvotes;
  final String hubName; 

  Post.named({
    required this.title,
    required this.body,
    required this.author,
    required this.imageUri,
    required this.upvotes,
    required this.downvotes,
    required this.hubName,
  });
}
