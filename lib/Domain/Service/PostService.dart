import 'package:qhub/Domain/Locators.dart';
import 'package:qhub/Domain/Service/Client.dart';
import 'package:qhub/Domain/Elements/Post.dart';

/// Used for performing operations on a post: load (update), upvote/downvote, etc.
/// To update the data, call [update] and access [post] when the update completes.
class PostService {
  final _dio = locator<Client>().dio;
  Post? _post;
  final String _id;

  /// Load the post by the provided [id]
  PostService.load(String id) : _id = id {
    update();
  }

  /// Use this if you have an existing [Post]
  PostService.existing(Post post) : _id = post.id {
    this._post = post;
  }

  Post? get post => _post;

  /// Requests the post from the server by the id, provided in the constructor, and updates the 
  /// value of [post].
  void update() async {
    _post = Post(
      id: _id,
      title: 'title',
      body: 'body',
      author: 'author',
      upvotes: 10,
      downvotes: 2,
      hubName: 'hubname',
    );
  }

  /// Return false if upvote wasn't allowed (e.g. already upvoted)
  Future<bool> upvote() async {
    return true;
  }

  /// Return false if downvote wasn't allowed (e.g. already downvoted)
  Future<bool> downvote() async {
    return true;
  }
}
