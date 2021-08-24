import 'package:qhub/Domain/Elements/Post.dart';

/// Model for creating or editing a post. Provides validators for input
class PostFormModel {
  String? _community;
  String? _imagePath;
  String _title = '';
  String _body = '';

  PostFormModel({String? community}) : _community = community;

  /// Constructs a model for editing an existing post. Verifies if the post is editable (user is the 
  /// author)
  /// TODO: how to deal with imagePath?
  PostFormModel.edit(Post post)
      : _community = post.hubName,
        _title = post.title,
        _body = post.body;

  set title(String t) {
    _title = t;
  }

  set body(String t) {
    _body = t;
  }

  set community(String t) {
    _community = t;
  }

  set imagePath(String t) {
    _imagePath = t;
  }

  Future<bool> submit() async {
    return Future<bool>.delayed(Duration(milliseconds: 1000), () => true);
  }
}
