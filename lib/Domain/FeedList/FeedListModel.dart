import 'package:qhub/Domain/Feed/FeedQuery.dart';


/// Provides a list of feeds (hub, blog or a custom feed) that user is subscribed to.
class FeedListModel {
  final blogs = <FeedQuery>[];
  final hubs = <FeedQuery>[];
  final customFeeds = <FeedQuery>[];
  late final List<FeedQuery> allFeeds;

  FeedListModel() {
    blogs.addAll([
      FeedQuery(hubName: 'blogA'),
      FeedQuery(hubName: 'blogB'),
      FeedQuery(hubName: 'blogC'),
    ]);
    hubs.addAll([
      FeedQuery(hubName: 'programming'),
      FeedQuery(hubName: 'questions'),
      FeedQuery(hubName: 'anime'),
      FeedQuery(hubName: 'games'),
      FeedQuery(hubName: 'something'),
      FeedQuery(hubName: 'movies'),
    ]);
    customFeeds.addAll([
      FeedQuery(hubName: 'myCustomFeed1'),
      FeedQuery(hubName: 'myCustomFeed2'),
    ]);

    allFeeds = blogs + hubs + customFeeds;
  }

}
