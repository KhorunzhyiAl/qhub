import 'package:flutter/material.dart';
import 'package:qhub/Screens/Widgets/PostWidget/PostWidget.dart';

import 'package:qhub/Domain/Models/FeedModel.dart';

class PostListWidget extends StatefulWidget {
  final FeedModel _feedModel;
  final void Function(ScrollController)? onScroll;

  PostListWidget(this._feedModel, {this.onScroll});

  @override
  State<StatefulWidget> createState() => _PostListWidgetSate();
}

class _PostListWidgetSate extends State<PostListWidget> {
  var _controller = ScrollController();

  @override
  void initState() {
    _controller.addListener(_scrollListener);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return CustomScrollView(
      slivers: [
        SliverAppBar(
          floating: true,
          shadowColor: theme.shadowColor,
          backgroundColor: theme.colorScheme.primary.withAlpha(240),
          leading: Container(
            alignment: Alignment.center,
            child: IconButton(
              onPressed: () {},
              icon: Icon(Icons.menu),
              color: theme.colorScheme.onPrimary,
            ),
          ),
          title: Text(
            widget._feedModel.feedParameters.hubName,
            style: theme.textTheme.headline1?.copyWith(color: theme.colorScheme.onPrimary),
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              return Column(
                children: [
                  PostWidget(widget._feedModel.posts[index]),
                  if (index < widget._feedModel.posts.length - 1)
                    Divider(
                      height: 5,
                      color: theme.colorScheme.onBackground.withAlpha(50),
                    ),
                ],
              );
            },
            childCount: widget._feedModel.posts.length,
          ),
        ),
      ],
      controller: _controller,
    );
  }

  void _scrollListener() async {
    if (_controller.position.extentAfter < 500) {
      await widget._feedModel.loadMore();
      setState(() {});
    }

    widget.onScroll?.call(_controller);
  }
}
