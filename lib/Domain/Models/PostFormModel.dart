import 'package:flutter/cupertino.dart';
import 'package:qhub/Domain/Elements/Post.dart';

/// Model for creating or editing a post. Provides validators for input
class PostFormModel {
  final communityValNotifier = ValueNotifier<String?>(null);
  final imagePathValNotifier = ValueNotifier<String?>(null);
  final titleValNotifier = ValueNotifier<String>('');
  final bodyValNotifier = ValueNotifier<String>('');



  String? get community => communityValNotifier.value;
  String? get imagePath => imagePathValNotifier.value;
  String get title => titleValNotifier.value;
  String get body => bodyValNotifier.value;

  set community(String? t) {
    communityValNotifier.value = t ?? communityValNotifier.value;
  }

  set imagePath(String? t) {
    imagePathValNotifier.value = t;
  }

  set title(String t) {
    titleValNotifier.value = t;
  }

  set body(String t) {
    bodyValNotifier.value = t;
  }

  PostFormModel({String? community}) {
    this.communityValNotifier.value = community;
  }

  /// Constructs a model for editing an existing post. Verifies if the post is editable (user is the
  /// author)
  /// TODO: how to deal with imagePath?
  PostFormModel.edit(Post post) {
    communityValNotifier.value = post.hubName;
    imagePathValNotifier.value = post.imageUri;
    titleValNotifier.value = post.title;
    bodyValNotifier.value = post.body;
  }

  Future<bool> submit() async {
    return Future<bool>.delayed(Duration(milliseconds: 1000), () => true);
  }
}
