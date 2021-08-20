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
  Future<void> update() async {
    _post = Post(
      id: _id,
      title: """Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam""",
      body: """Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source. Lorem Ipsum comes from sections 1.10.32 and 1.10.33 of "de Finibus Bonorum et Malorum" (The Extremes of Good and Evil) by Cicero, written in 45 BC. This book is a treatise on the theory of ethics, very popular during the Renaissance. The first line of Lorem Ipsum, "Lorem ipsum dolor sit amet..", comes from a line in section 1.10.32.

The standard chunk of Lorem Ipsum used since the 1500s is reproduced below for those interested. Sections 1.10.32 and 1.10.33 from "de Finibus Bonorum et Malorum" by Cicero are also reproduced in their exact original form, accompanied by English versions from the 1914 translation by H. Rackham.
""",
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
