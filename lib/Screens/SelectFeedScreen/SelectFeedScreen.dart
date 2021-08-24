import 'package:flutter/material.dart';
import 'package:qhub/Domain/Models/FeedListModel.dart';
import 'package:qhub/Screens/SelectFeedScreen/Other/FeedWidget.dart';
import 'package:qhub/Screens/SelectFeedScreen/Other/SeparatorWidget.dart';

/// Screen for selecting a hub/blog/feed. Returns [FeedParameters] via pop()
class SelectHubScreen extends StatelessWidget {
  final _model = FeedListModel();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final list = _buildList(context);

    return Container(
      color: theme.colorScheme.background,
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            backgroundColor: theme.colorScheme.primary.withAlpha(240),
            foregroundColor: theme.colorScheme.onPrimary,
            backwardsCompatibility: false,
            shadowColor: theme.shadowColor,
            title: Text('Select feed', style: theme.textTheme.headline3),
          ),
          SliverToBoxAdapter(
            child: Column(children: list),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildList(BuildContext context) {
    final result = <Widget>[];
    final nav = Navigator.of(context);

    result.add(SizedBox(height: 10));

    if (_model.blogs.isNotEmpty) {
      result.add(SeparatorWidget(text: 'blogs'));
      result.addAll(_model.blogs.map((e) {
        return FeedWidget(
          e,
          onSelected: (feed) {
            nav.pop(feed);
          },
        );
      }));
    }
    if (_model.hubs.isNotEmpty) {
      result.add(SeparatorWidget(text: 'hubs'));
      result.addAll(_model.hubs.map((e) {
        return FeedWidget(
          e,
          onSelected: (feed) {
            nav.pop(feed);
          },
        );
      }));
    }
    if (_model.customFeeds.isNotEmpty) {
      result.add(SeparatorWidget(text: 'custom'));
      result.addAll(_model.customFeeds.map((e) {
        return FeedWidget(
          e,
          onSelected: (feed) {
            nav.pop(feed);
          },
        );
      }));
    }

    return result;
  }
}
