import 'package:flutter/material.dart';
import 'package:qhub/Domain/Models/PostModel.dart';
import 'package:qhub/Screens/Post/Other/CommentsPage.dart';
import 'package:qhub/Screens/Post/Other/PostPage.dart';
import 'package:qhub/Screens/Widgets/PostInfo.dart';

class PostScreen extends StatelessWidget {
  final PostModel postModel;

  PostScreen({required this.postModel});

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
              leading: Container(
                alignment: Alignment.center,
                child: IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.menu),
                  color: theme.colorScheme.onPrimary,
                ),
              ),
              title: Text(
                'todo',
                style: theme.textTheme.headline1?.copyWith(color: theme.colorScheme.onPrimary),
              ),
            ),
          ];
        },
        body: PageView(
          children: <Widget>[
            PostPage(postModel),
            CommentsPage(postModel),
          ],
        ),
      ),
    );
  }
}
