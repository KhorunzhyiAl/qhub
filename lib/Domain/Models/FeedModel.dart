import 'package:flutter/foundation.dart';
import 'package:qhub/Domain/Service/FeedService.dart';
import 'package:qhub/Domain/Elements/Feed.dart';
import 'package:qhub/Domain/Elements/Post.dart';

/// Not sure on the best method to notify about changes in the list of posts. Currently, I'm 
/// extending [ChangeNotifier], and calling [notifyListeners] when: 
///   - adding more posts to the list
///   - updating the list (when calling [update] or [setParameters])
class FeedModel extends ChangeNotifier {
  late FeedService _service;
  final List<Post> posts = [];

  FeedParameters get feedParameters => _service.feed.parameters;

  FeedModel(FeedParameters parameters) {
    _initService(parameters);
  }

  /// Sets the specified parameters and refreshes the list of posts
  Future<void> setParameters(FeedParameters parameters) async {
    posts.clear();
    _initService(parameters);
    await _service.loadNext(100);
    notifyListeners();
  }

  /// Reloads the list of posts preserving the parameters.
  Future<void> update() async {
    posts.clear();
    _initService(_service.feed.parameters);
    await _service.loadNext(100);
    notifyListeners();
  }

  Future<void> loadMore() async {
    await _service.loadNext(100);
  }

  void _initService(FeedParameters parameters) {
    _service = FeedService(parameters);
    _service.feed.posts.listen(_addPost);
  }

  void _addPost(Post post) {
    posts.add(post);
  }
}
