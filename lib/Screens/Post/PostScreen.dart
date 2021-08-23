import 'package:flutter/material.dart';
import 'package:qhub/Domain/Models/PostModel.dart';
import 'package:qhub/Screens/Post/Other/CommentsPage.dart';
import 'package:qhub/Screens/Post/Other/PostPage.dart';
import 'package:qhub/Screens/Widgets/PostInfo.dart';

class PostScreen extends StatefulWidget {
  final PostModel postModel;

  PostScreen({required this.postModel});

  @override
  _PostScreenState createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> with TickerProviderStateMixin {
  late final TabController _tabController;
  late final PageController _pageController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    _pageController = PageController();

    _tabController.addListener(_tabListener);
    _pageController.addListener(_pageListener);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      color: theme.colorScheme.background,
      child: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              floating: true,
              shadowColor: theme.shadowColor,
              backgroundColor: theme.colorScheme.primary.withAlpha(240),
              leading: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: Icon(
                  Icons.arrow_back,
                  color: theme.colorScheme.onPrimary,
                ),
              ),
              bottom: TabBar(
                indicatorColor: theme.colorScheme.onPrimary,
                indicatorWeight: 3,
                indicatorPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                controller: _tabController,

                labelStyle: theme.textTheme.headline6,
                labelColor: theme.colorScheme.onPrimary,
                tabs: <Widget>[
                  Tab(text: 'Post'),
                  Tab(text: 'Comments'),
                ],
              ),
            ),
          ];
        },
        body: PageView(
          controller: _pageController,
          children: <Widget>[
            PostPage(widget.postModel),
            CommentsPage(widget.postModel),
          ],
        ),
        
      ),
    );
  }

  void _tabListener() {
    _pageController.animateToPage(
      _tabController.index,
      duration: Duration(milliseconds: 100),
      curve: Curves.easeOutSine,
    );
  }

  void _pageListener() {
    if (_pageController.page != null && !_tabController.indexIsChanging)
      _tabController.offset = _pageController.page! - _tabController.index;
  }
}
