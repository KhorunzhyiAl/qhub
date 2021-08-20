import 'package:flutter/material.dart';
import 'package:qhub/Domain/Models/PostModel.dart';
import 'package:qhub/Screens/Widgets/PostInfo.dart';

class PostScreen extends StatelessWidget {
  final PostModel postModel;

  PostScreen({required this.postModel});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      color: theme.colorScheme.background,
      child: CustomScrollView(
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
              'todo',
              style: theme.textTheme.headline1?.copyWith(color: theme.colorScheme.onPrimary),
            ),
          ),

          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            sliver: SliverToBoxAdapter(
              child: Container(
                color: theme.colorScheme.background,
                constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    if (postModel.post.imageUri != null) ...[
                      Image.network(
                        'https://picsum.photos/700/850',
                        fit: BoxFit.cover,
                        loadingBuilder: (context, child, progress) {
                          print(
                              'received: ${progress?.cumulativeBytesLoaded}, expected: ${progress?.expectedTotalBytes}');
                          if (progress == null) {
                            return child;
                          }
                          return Container(color: Colors.blue, height: 100, width: 100);
                        },
                      ),
                      SizedBox(height: 30),
                    ],
                    Text(postModel.post.title, style: theme.textTheme.headline1),
                    SizedBox(height: 10),
                    PostInfo(postModel: postModel),
                    SizedBox(height: 40),
                    Text(
                      postModel.post.body,
                      style: theme.textTheme.bodyText1,
                      textAlign: TextAlign.left,
                    ),
                  ],
                ),
              ),
            ),
          ),
          // SliverList()
        ],
      ),
    );
  }
}
