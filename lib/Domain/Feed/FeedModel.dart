import 'dart:collection';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:qhub/Domain/Feed/Post.dart';
import 'package:qhub/Other/PropertyNotifier.dart';
import 'package:qhub/Domain/Feed/FeedQuery.dart';

/// Contains [ValueNotifier]s for the list of posts and feed parameters and functionality to
/// interact with the feed.
///
/// The [posts] list is lazy-loaded. Use [loadMore] posts to load the next batch of posts when
/// approaching the end of the current list. [postsNotifier] will notify its listeners when
/// [loadMore] finishes.
class FeedModel {
  final _posts = <Post>[];
  bool _isLoadingPosts = false;

  // The reason for using [PropertyNotifier] (custom class) instead of [ValueNotifier] is
  // because the values are being mutated instead of changed entirely, which doesn't trigger
  // [ValueNotifier]'s [notifyListeners]. [PropertyNotifier] lets me call [notifyListeners]
  // explicitly.
  // Made it private with a getter to hide [PropertyNotifier] (the getter returns [ValueNotifier])
  late final PropertyNotifier<UnmodifiableListView<Post>> _postsNotifier;

  /// For usage in [ValueListenableBuilder] or [ValueListenableProvider]. To create a new feed with
  /// different parameters, call [setParameters]. The list of posts [posts] becomes empty after this
  /// this value changes because it's a new feed now.
  final ValueNotifier<FeedQuery> parametersNotifier;

  /// Contains the currently loaded posts. Call [loadMore] and the value will be updated when the
  /// loading finishes.
  ValueNotifier<UnmodifiableListView<Post>> get postsNotifier => _postsNotifier;

  /// Creates a feed model with the specified [parameters]. The [posts] list is initially empty;
  /// call [loadMore] to load the first batch of posts.
  FeedModel(FeedQuery parameters) : parametersNotifier = PropertyNotifier(parameters) {
    _postsNotifier = PropertyNotifier<UnmodifiableListView<Post>>(UnmodifiableListView(_posts));
  }

  /// Sets the specified parameters and clears [posts]
  void setParameters(FeedQuery parameters) {
    this.parametersNotifier.value = parameters;
    _posts.clear();
    _postsNotifier.notifyListeners();
  }

  /// Reloads the list of posts preserving the parameters. [loadPosts] - the amount of posts to load
  /// after updating (default is 100)
  Future<void> update([int loadPosts = 100]) async {
    final newPosts = await _loadMore(loadPosts);
    _posts.clear();
    _posts.addAll(newPosts);
    _postsNotifier.notifyListeners();
  }

  /// Starts loading the next batch of posts. When finished, [postsNotifier] notifies its listeners.
  Future<void> loadMore() async {
    _posts.addAll(await _loadMore(100, _posts.length));
    _postsNotifier.notifyListeners();
  }

  /// Loads and returns a list of [amount] posts with the [offset]
  Future<List<Post>> _loadMore(int amount, [int offset = 0]) async {
    final result = <Post>[];

    if (_isLoadingPosts || amount <= 0) return result;

    _isLoadingPosts = true;
    await Future.delayed(Duration(seconds: 2));
    _isLoadingPosts = false;

    final ra = Random.secure();
    for (int i = 0; i < amount; ++i) {
      result.add(Post(
        id: '$i',
        title:
            """Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam""",
        body:
            """Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source. Lorem Ipsum comes from sections 1.10.32 and 1.10.33 of "de Finibus Bonorum et Malorum" (The Extremes of Good and Evil) by Cicero, written in 45 BC. This book is a treatise on the theory of ethics, very popular during the Renaissance. The first line of Lorem Ipsum, "Lorem ipsum dolor sit amet..", comes from a line in section 1.10.32.

The standard chunk of Lorem Ipsum used since the 1500s is reproduced below for those interested. Sections 1.10.32 and 1.10.33 from "de Finibus Bonorum et Malorum" by Cicero are also reproduced in their exact original form, accompanied by English versions from the 1914 translation by H. Rackham.
""",
        author: 'author',
        upvotes: 10,
        downvotes: 2,
        hubName: 'hubname',
        imageUri: ra.nextBool() ? null : 'imageid',
      ));
    }

    return result;
  }
}
