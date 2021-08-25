import 'package:flutter/material.dart';
import 'package:qhub/Domain/Elements/Feed.dart';
import 'package:qhub/Domain/Models/FeedModel.dart';
import 'package:qhub/Domain/Models/PostFormModel.dart';
import 'package:qhub/Domain/Elements/Post.dart';
import 'package:qhub/Screens/Widgets/PostWidget/PostWidget.dart';
import 'package:qhub/Screens/Widgets/FloatingButton/FloatingPopup.dart';
import 'package:qhub/Screens/Widgets/FloatingButton/Other/FloatingPopupElement.dart';
import 'package:qhub/Domain/Navigation/Routes.dart';

class FeedScreen extends StatefulWidget {
  final _feedModel = FeedModel(FeedParameters(hubName: 'home'));
  final _controller = ScrollController();

  @override
  _FeedScreenState createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> with SingleTickerProviderStateMixin {
  var isLoadingMore = false;

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
    if (!isLoadingMore && widget._controller.position.extentAfter < 500) {
      widget._feedModel.loadMore();
      isLoadingMore = true;
    }
  }

  void _setFeedParameters(FeedParameters? params) async {
    await widget._controller.animateTo(
      0,
      duration: Duration(milliseconds: 10),
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
          body: ValueListenableBuilder<FeedParameters>(
              valueListenable: widget._feedModel.parameters,
              builder: (_, parameters, __) {
                return Container(
                  color: theme.colorScheme.background,
                  child: CustomScrollView(
                    controller: widget._controller,
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
                          widget._feedModel.parameters.value.hubName,
                          style: theme.textTheme.headline1
                              ?.copyWith(color: theme.colorScheme.onPrimary),
                        ),
                      ),
                      ValueListenableBuilder<List<Post>>(
                        valueListenable: widget._feedModel.posts,
                        builder: (_, posts, __) {
                          isLoadingMore = false;

                          if (posts.length == 0) widget._feedModel.loadMore();

                          return SliverList(
                            delegate: SliverChildBuilderDelegate(
                              (context, index) {
                                if (index == posts.length) {
                                  return Container(
                                    height: 100,
                                    child: Center(
                                      child: CircularProgressIndicator(
                                        color: theme.colorScheme.onBackground,
                                        backgroundColor: Colors.transparent,
                                      ),
                                    ),
                                  );
                                }
                                return PostWidget(posts[index]);
                              },
                              /// The last element is loading indicator
                              childCount: posts.length + 1,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                );
              }),
        ),
        FloatingPopup(
          options: [
            FloatingPopupElement(
              message: 'home',
              icon: Icons.home,
              onPressed: () {
                _setFeedParameters(FeedParameters(hubName: 'home'));
              },
            ),
            FloatingPopupElement(
              message: 'communities',
              icon: Icons.list,
              onPressed: () async {
                FeedParameters? result = await nav.pushNamed(Routes.selectFeed);
                _setFeedParameters(result);
              },
            ),
            FloatingPopupElement(
              message: 'create post',
              icon: Icons.create,
              onPressed: () {
                nav.pushNamed(Routes.createPost,
                    arguments:
                        PostFormModel(community: widget._feedModel.parameters.value.hubName));
              },
            ),
          ],
        ),
      ],
    );
  }
}
