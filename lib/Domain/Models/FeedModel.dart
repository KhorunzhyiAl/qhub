import 'package:qhub/Domain/Service/FeedService.dart';
import 'package:qhub/Domain/Elements/Feed.dart';
import 'package:qhub/Domain/Elements/Post.dart';
import 'package:qhub/Other/PropertyNotifier.dart';

class FeedModel {
  FeedService _service;

  late final PropertyNotifier<FeedParameters> parameters;
  late final PropertyNotifier<List<Post>> posts;

  FeedModel(FeedParameters parameters) : _service = FeedService(parameters) {
    posts = PropertyNotifier<List<Post>>(_service.posts);
    this.parameters = PropertyNotifier<FeedParameters>(_service.parameters);
  }

  /// Sets the specified parameters and refreshes the list of posts
  Future<void> setParameters(FeedParameters parameters) async {
    _initService(parameters);
  }

  /// Reloads the list of posts preserving the parameters.
  Future<bool> update() async {
    // reinitialize [FeedService] with the same parameters and load first 100 posts.
    _initService(_service.parameters);
    final result = await _service.loadNext(10);
    posts.notifyListeners();

    return result;
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
