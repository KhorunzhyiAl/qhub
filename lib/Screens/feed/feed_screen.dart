import 'dart:collection';
import 'package:dartz/dartz.dart' as dartz;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qhub/domain/feed/feed_model.dart';
import 'package:qhub/domain/submit_post/post_form_model.dart';
import 'package:qhub/domain/feed/post.dart';
import 'package:qhub/screens/widgets/drawer/drawer.dart';
import 'package:qhub/screens/widgets/post_widget/post_widget.dart';
import 'package:qhub/screens/widgets/floating_button/floating_button.dart';
import 'package:qhub/screens/widgets/floating_button/other/floating_button_element.dart';
import 'package:qhub/domain/navigation/routes.dart';
import 'package:qhub/domain/feed/feed_query.dart';

class FeedScreen extends StatefulWidget {
  final _feedModel = FeedModel(FeedQuery(hubName: 'home'));
  final _controller = ScrollController();

  @override
  _FeedScreenState createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> with SingleTickerProviderStateMixin {
  var isLoadingMore = false;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    widget._controller.addListener(_scrollListener);
    super.initState();
  }

  @override
  void dispose() {
    widget._controller.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (!isLoadingMore &&
        widget._controller.position.extentAfter < 500 &&
        !widget._feedModel.noMorePosts) {
      widget._feedModel.loadMore();
      isLoadingMore = true;
    }
  }

  void _setFeedParameters(FeedQuery? params) async {
    await widget._controller.animateTo(
      0,
      duration: Duration(milliseconds: 50),
      curve: Curves.linear,
    );
    if (params != null) widget._feedModel.setParameters(params);
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var nav = Navigator.of(context);

    return Stack(
      children: [
        Scaffold(
          key: _scaffoldKey,
          drawer: MyDrawer(),
          body: Container(
            color: theme.colorScheme.background,
            child: CustomScrollView(
              physics: BouncingScrollPhysics(),
              controller: widget._controller,
              slivers: [
                ValueListenableBuilder<FeedQuery>(
                  valueListenable: widget._feedModel.parametersNotifier,
                  builder: (_, parameters, __) {
                    return SliverAppBar(
                      floating: true,
                      shadowColor: theme.shadowColor,
                      backgroundColor: theme.colorScheme.primary.withAlpha(240),
                      leading: Container(
                        alignment: Alignment.center,
                        child: IconButton(
                          onPressed: () {
                            _scaffoldKey.currentState?.openDrawer();
                          },
                          icon: Icon(Icons.menu),
                          color: theme.colorScheme.onPrimary,
                        ),
                      ),
                      title: Text(
                        widget._feedModel.parametersNotifier.value.hubName,
                        style:
                            theme.textTheme.headline1?.copyWith(color: theme.colorScheme.onPrimary),
                      ),
                    );
                  },
                ),
                CupertinoSliverRefreshControl(
                  onRefresh: () async {
                    await widget._feedModel.update();
                  },
                  builder: (
                    context,
                    refreshState,
                    pulledExtent,
                    refreshTriggerPullDistance,
                    refreshIndicatorExtent,
                  ) {
                    final percentageComplete =
                        (pulledExtent / refreshTriggerPullDistance).clamp(0.0, 1.0);
                    final showLoading = refreshState != RefreshIndicatorMode.drag;
                    final isDone = refreshState == RefreshIndicatorMode.done ||
                        refreshState == RefreshIndicatorMode.inactive;

                    return Center(
                      child: Stack(
                        clipBehavior: Clip.none,
                        alignment: Alignment.center,
                        children: <Widget>[
                          Positioned(
                            width: 30,
                            height: 30,
                            child: CircularProgressIndicator(
                              value: showLoading ? null : percentageComplete,
                              color: isDone
                                  ? theme.colorScheme.onBackground.withOpacity(percentageComplete)
                                  : theme.colorScheme.onBackground,
                              backgroundColor: Colors.transparent,
                              strokeWidth: isDone ? percentageComplete * 4.0 : 4.0,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                ValueListenableBuilder<UnmodifiableListView<Post>>(
                  valueListenable: widget._feedModel.postsNotifier,
                  builder: (_, posts, __) {
                    isLoadingMore = false;

                    if (posts.length == 0 && !widget._feedModel.noMorePosts)
                      widget._feedModel.loadMore();

                    return SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          if (index == posts.length) {
                            if (widget._feedModel.noMorePosts) {
                              return Container(
                                height: 200,
                                alignment: Alignment.center,
                                child: OutlinedButton(
                                  onPressed: () async {
                                    await widget._controller.animateTo(
                                      0,
                                      duration: Duration(milliseconds: 80),
                                      curve: Curves.linear,
                                    );
                                    widget._feedModel.clearThenUpdate();
                                  },
                                  child: Container(
                                    width: 150,
                                    height: 50,
                                    alignment: Alignment.center,
                                    child: Text('Refresh', style: theme.textTheme.headline5),
                                  ),
                                ),
                              );
                            }
                            return Container(
                              height: 100,
                              child: Center(
                                child: SizedBox(
                                  width: 30,
                                  height: 30,
                                  child: CircularProgressIndicator(
                                    color: theme.colorScheme.onBackground,
                                    backgroundColor: Colors.transparent,
                                  ),
                                ),
                              ),
                            );
                          }
                          return PostWidget(posts[index]);
                        },

                        /// The last element is loading indicator or a message
                        childCount: posts.length + 1,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
        FloatingPopup(
          options: [
            FloatingPopupElement(
              message: 'home',
              icon: Icons.home,
              onPressed: () {
                _setFeedParameters(FeedQuery(hubName: 'home'));
              },
            ),
            FloatingPopupElement(
              message: 'communities',
              icon: Icons.list,
              onPressed: () async {
                FeedQuery? result = await nav.pushNamed(Routes.selectFeed);
                _setFeedParameters(result);
              },
            ),
            FloatingPopupElement(
              message: 'create post',
              icon: Icons.create,
              onPressed: () {
                nav.pushNamed(
                  Routes.createPost,
                  arguments: PostFormModel(
                    community: dartz.Some(widget._feedModel.parametersNotifier.value.hubName),
                  ),
                );
              },
            ),
          ],
        ),
      ],
    );
  }
}
