import 'package:flutter/material.dart';
import 'package:qhub/Domain/Feed/PostModel.dart';
import 'package:qhub/Screens/Widgets/PostInfo.dart';

class PostPage extends StatelessWidget {
  final PostModel postModel;

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
                        loadingBuilder: (_, __, ___) {
                          return Container(height: 300, color: Colors.grey);
                        },
                        errorBuilder: (_, __, ___) {
                          return Container(
                            height: 300,
                            color: Colors.grey,
                            child: Icon(Icons.image, color: Colors.white),
                          );
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
                    style: theme.textTheme.bodyText2,
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
