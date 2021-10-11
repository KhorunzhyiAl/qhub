import 'dart:collection';

import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:qhub/domain/core/api.dart';
import 'package:qhub/domain/core/flashbar_controller.dart';
import 'package:qhub/domain/feed/post.dart';
import 'package:qhub/domain/locators.dart';
import 'package:qhub/other/property_notifier.dart';
import 'package:qhub/domain/feed/feed_query.dart';

/// Contains [ValueNotifier]s for the list of posts and feed parameters and functionality to
/// interact with the feed.
///
/// The [posts] list is lazy-loaded. Use [loadMore] posts to load the next batch of posts when
/// approaching the end of the current list. [postsNotifier] will notify its listeners when
/// [loadMore] finishes.
class FeedModel {
  final _posts = <Post>[];
  bool _isLoadingPosts = false;
  final _flashbar = locator<FlashbarController>();
  bool _noMorePosts = false;
  bool _connectionFailed = false;

  late final PropertyNotifier<UnmodifiableListView<Post>> _postsNotifier;

  /// For usage in [ValueListenableBuilder] or [ValueListenableProvider]. To create a new feed with
  /// different parameters, call [setParameters]. The list of posts [posts] becomes empty after this
  /// this value changes because it's a new feed now.
  final ValueNotifier<FeedQuery> parametersNotifier;

  /// Contains the currently loaded posts. Call [loadMore] and the value will be updated when the
  /// loading finishes.
  ValueNotifier<UnmodifiableListView<Post>> get postsNotifier => _postsNotifier;

  /// all posts for the feed have been loaded. Stop spamming [loadMore], please
  bool get noMorePosts => _noMorePosts;

  /// Creates a feed model with the specified [parameters]. The [posts] list is initially empty;
  /// call [loadMore] to load the first batch of posts.
  FeedModel(FeedQuery parameters) : parametersNotifier = PropertyNotifier(parameters) {
    _postsNotifier = PropertyNotifier<UnmodifiableListView<Post>>(UnmodifiableListView(_posts));
  }

  /// Sets the specified parameters and clears [posts]
  void setParameters(FeedQuery parameters) {
    this.parametersNotifier.value = parameters;
    _noMorePosts = false;
    _posts.clear();
    _postsNotifier.notifyListeners();
  }

  /// Reloads the list of posts preserving the parameters. [loadPosts] - the amount of posts to load
  /// after updating (default is 100)
  Future<void> update([int loadPosts = 100]) async {
    _noMorePosts = false;
    final newPosts = await _loadMore(loadPosts);
    _posts.clear();
    _posts.addAll(newPosts);
    _postsNotifier.notifyListeners();
  }

  /// Clears the list of posts first, only then starts loading the new ones (unlike [update])
  Future<void> clearThenUpdate([int loadPosts = 100]) async {
    _noMorePosts = false;
    _posts.clear();
    _postsNotifier.notifyListeners();
    _posts.addAll(await _loadMore(loadPosts));
    _postsNotifier.notifyListeners();
  }

  /// Starts loading the next batch of posts. When finished, [postsNotifier] notifies its listeners.
  Future<void> loadMore() async {
    _posts.addAll(await _loadMore(100, _posts.length));
    _postsNotifier.notifyListeners();
  }

  /// Loads and returns a list of [amount] posts with the [offset]
  Future<List<Post>> _loadMore(int amount, [int offset = 0]) async {
    if (_isLoadingPosts || amount <= 0) return [];

    _isLoadingPosts = true;

    final resOrFailure = await loadMorePosts(amount, offset);
    final result = resOrFailure.fold<List<Post>>(
      (l) {
        return <Post>[];
      },
      (r) {
        if (r.length < amount) _noMorePosts = true;
        return r;
      },
    );

    _isLoadingPosts = false;

    return result;
  }
}
