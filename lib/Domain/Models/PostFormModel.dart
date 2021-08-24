import 'package:qhub/Domain/Elements/Post.dart';

/// Model for creating or editing a post. Provides validators for input
class PostFormModel {
  String? community;
  String? imagePath;
  String title = '';
  String body = '';

  PostFormModel({String? community}) : community = community;

  /// Constructs a model for editing an existing post. Verifies if the post is editable (user is the 
  /// author)
  /// TODO: how to deal with imagePath?
  PostFormModel.edit(Post post)
      : community = post.hubName,
        title = post.title,
        body = post.body;

  Future<bool> submit() async {
    return Future<bool>.delayed(Duration(milliseconds: 1000), () => true);
  }
}
