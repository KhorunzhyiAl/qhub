import 'package:flutter/material.dart';
import 'package:qhub/Screens/Widgets/PostWidget/PostWidget.dart';

import 'package:qhub/Domain/Models/FeedModel.dart';

class PostListWidget extends StatefulWidget {
  final FeedModel _feedModel;

  PostListWidget(this._feedModel);

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
    return ListView.builder(
      itemBuilder: (context, index) {
        return PostWidget(widget._feedModel.posts[index]);
      },
      itemCount: widget._feedModel.posts.length,
      controller: _controller,
    );
  }

  void _scrollListener() async {
    if (_controller.position.extentAfter < 500) {
      await widget._feedModel.loadMore();
      setState(() {});
    }
  }
}
