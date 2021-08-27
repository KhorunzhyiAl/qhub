class Post {
  final bool _loaded;

  final String id;
  final String title;
  final String body;
  final String author;
  final int upvotes;
  final int downvotes;
  final String hubName;
  final String? imageUri;

  /// True, if the post was (for any reason) not loaded when the object was created. Use 
  /// [Post.unknown] constructor if you need to indicate that the post is not loaded
  bool get loaded => _loaded; 

  Post({
    required this.id,
    required this.title,
    required this.body,
    required this.author,
    required this.upvotes,
    required this.downvotes,
    required this.hubName,
    this.imageUri,
  }) : _loaded = true;

  /// Use this constructor to indicate that the post is not loaded
  Post.unknown({
    this.id = '',
    this.title = '',
    this.body = '',
    this.author = '',
    this.upvotes = 0,
    this.downvotes = 0,
    this.hubName = '',
    this.imageUri,
  }) : _loaded = false;
}
