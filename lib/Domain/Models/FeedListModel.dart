import 'package:qhub/Domain/Elements/Feed.dart';

/// Provides a list of feeds (hub, blog or a custom feed) that user is subscribed to.
///
class FeedListModel {
  final blogs = <FeedParameters>[];
  final hubs = <FeedParameters>[];
  final customFeeds = <FeedParameters>[];
  late final List<FeedParameters> allFeeds;

  FeedListModel() {
    // initialize the lists
    blogs.addAll([
      FeedParameters(hubName: 'blogA'),
      FeedParameters(hubName: 'blogB'),
      FeedParameters(hubName: 'blogC'),
    ]);
    hubs.addAll([
      FeedParameters(hubName: 'programming'),
      FeedParameters(hubName: 'questions'),
      FeedParameters(hubName: 'anime'),
      FeedParameters(hubName: 'games'),
      FeedParameters(hubName: 'something'),
      FeedParameters(hubName: 'movies'),
    ]);
    customFeeds.addAll([
      FeedParameters(hubName: 'myCustomFeed1'),
      FeedParameters(hubName: 'myCustomFeed2'),
    ]);

    allFeeds = blogs + hubs + customFeeds;
  }

}
