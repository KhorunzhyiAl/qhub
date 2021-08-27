import 'package:qhub/Domain/Feed/FeedService.dart';
import 'package:qhub/Domain/Feed/Feed.dart';
import 'package:qhub/Domain/Feed/Post.dart';
import 'package:qhub/Other/PropertyNotifier.dart';

/// Contains [PropertyNotifier]s for feed data and functionality to interact with the feed.
/// 
/// The [posts] list is lazy-loaded. Use [loadMore] posts to load the next batch of posts when 
/// approaching the end of the current list. 

// P.S. The reason for using [PropertyNotifier] (custom class) instead of [ValueNotifier] is 
// because the values are being mutated instead of changed entirely, which doesn't trigger 
// [ValueNotifier]'s [notifyListeners] so I need to be able to call [notifyListeners] explicitly.
class FeedModel {  
  FeedService _service;

  /// For usage in [ValueListenableBuilder] or [ValueListenableProvider]. To create a new feed with
  /// different parameters, call [setParameters]. The list of posts [posts] becomes empty after this
  /// this value changes because it's a new feed now.
  late final PropertyNotifier<FeedParameters> parameters;
  /// Contains the currently loaded posts. Call [loadMore] and the value will be updated when the 
  /// loading finishes.
  late final PropertyNotifier<List<Post>> posts;

  /// Creates a feed model with the specified [parameters]. The [posts] list is initially empty; 
  /// call [loadMore] to load the first batch of posts.
  FeedModel(FeedParameters parameters) : _service = FeedService(parameters) {
    posts = PropertyNotifier<List<Post>>(_service.posts);
    this.parameters = PropertyNotifier<FeedParameters>(_service.parameters);
  }

  /// Sets the specified parameters and clears the list of posts ([posts])
  Future<void> setParameters(FeedParameters parameters) async {
    _initService(parameters);
  }

  /// Reloads the list of posts preserving the parameters.
  Future<void> update([int loadPosts = 0]) async {
    
    posts.notifyListeners();
  }

  Future<bool> loadMore() async {
    bool result = await _service.loadNext(10);

    if (!result) return false;

    print('loadMore notifies listeners');
    posts.notifyListeners(); 
    return result;
  }

  void _initService(FeedParameters parameters) {
    _service = FeedService(parameters);
    this.parameters.value = _service.parameters;
    posts.value = _service.posts;
  }
}
