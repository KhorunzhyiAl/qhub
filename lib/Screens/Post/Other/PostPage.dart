import 'package:flutter/material.dart';
import 'package:qhub/Domain/Models/PostModel.dart';
import 'package:qhub/Screens/Widgets/PostInfo.dart';

class PostPage extends StatelessWidget {
  PostModel postModel;

  PostPage(this.postModel);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return CustomScrollView(
      slivers: [
        SliverPadding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          sliver: SliverToBoxAdapter(
            child: Container(
              color: theme.colorScheme.background,
              // constraints: BoxConstraints(
              //   minHeight: MediaQuery.of(context).size.height,
              // ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  if (postModel.post.imageUri != null) ...[
                    SizedBox(height: 10),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(3),
                      child: Image.network(
                        'https://picsum.photos/700/700',
                        fit: BoxFit.cover,
                        loadingBuilder: (context, child, progress) {
                          if (progress == null) {
                            return child;
                          }
                          return Container(color: Colors.blue, height: 100, width: 100);
                        },
                      ),
                    ),
                    SizedBox(height: 10),
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
                  SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
