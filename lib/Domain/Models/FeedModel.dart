import 'package:flutter/foundation.dart';
import 'package:qhub/Domain/Service/FeedService.dart';
import 'package:qhub/Domain/Elements/Feed.dart';
import 'package:qhub/Domain/Elements/Post.dart';

/// Not sure on the best method to notify about changes in the list of posts. Currently, I'm 
/// extending [ChangeNotifier], and calling [notifyListeners] when: 
///   - adding more posts to the list
///   - updating the list (when calling [update] or [setParameters])
/// 
/// However, when the class gets larger, there will be much more changing members and listeners 
/// should not be notified about all unrelated changes.
class FeedModel extends ChangeNotifier {
  late FeedService _service;
  final List<Post> posts = [];

  FeedIdentifier get feedParameters => _service.feed.parameters;

  FeedModel(FeedIdentifier parameters) {
    _initService(parameters);
  }

  /// Sets the specified parameters and refreshes the list of posts
  Future<void> setParameters(FeedIdentifier parameters) async {
    posts.clear();
    _initService(parameters);
    await _service.loadNext(5);
    notifyListeners();
  }

  /// Reloads the list of posts preserving the parameters.
  Future<void> update() async {
    posts.clear();
    _initService(_service.feed.parameters);
    await _service.loadNext(5);
    notifyListeners();
  }

  Future<void> loadMore() async {
    await _service.loadNext(5);
  }

  void _initService(FeedIdentifier parameters) {
    _service = FeedService(parameters);
    _service.feed.posts.listen(_addPost);
  }

  void _addPost(Post post) {
    posts.add(post);
  }
}
