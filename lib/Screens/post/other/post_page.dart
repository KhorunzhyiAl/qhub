import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qhub/domain/feed/post.dart';
import 'package:qhub/domain/feed/post_model.dart';
import 'package:qhub/domain/utils.dart';
import 'package:qhub/screens/widgets/post_info.dart';

class PostPage extends StatelessWidget {
  final PostModel postModel;

  PostPage(this.postModel);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: postModel,
      builder: (_, child) {
        return postModel.post.fold(
          () => _loading(context),
          (loaded) => loaded.fold(
            () => _loadedNone(context),
            (postData) => _loadedPost(context, postData),
          ),
        );
      },
    );
  }

  Widget _loading(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      color: theme.colorScheme.background,
      child: Center(
        child: CircularProgressIndicator(
          color: theme.colorScheme.onBackground,
          backgroundColor: Colors.transparent,
        ),
      ),
    );
  }

  /// The [Future] (from [postModel.post]) is completed with an empty [Option].
  Widget _loadedNone(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      color: theme.colorScheme.background,
      child: Center(
        child: Text('Failed to load the post', style: theme.textTheme.headline3),
      ),
    );
  }

  /// The [Future] (from [postModel.post]) is completed with an [Option] containing [Post],
  Widget _loadedPost(BuildContext context, Post postData) {
    final theme = Theme.of(context);

    return CustomScrollView(
      physics: BouncingScrollPhysics(),
      slivers: [
        CupertinoSliverRefreshControl(
          onRefresh: () async {
            await postModel.update();
          },
        ),
        SliverPadding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          sliver: SliverToBoxAdapter(
            child: Container(
              color: Colors.transparent,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  ...postData.imageUri.fold(
                    () => [SizedBox.shrink()],
                    (a) => [
                      SizedBox(height: 10),
                      Hero(
                        tag: a,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(2),
                          child: Image.network(
                            Utils.createImageUrl(a),
                            fit: null,
                            loadingBuilder: (_, child, chunk) {
                              if (chunk == null) {
                                return Container(
                                  child: child,
                                );
                              }
                              return Container(
                                height: MediaQuery.of(context).size.width - 20,
                                color: Colors.grey,
                                child: child,
                              );
                            },
                            errorBuilder: (_, exeption, __) {
                              print('[postPage.dart] failed to load image: $exeption');
                              return Container(
                                height: 300,
                                color: Colors.grey,
                                child: Icon(Icons.image, color: Colors.white),
                              );
                            },
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                    ],
                  ),
                  Text(postData.title, style: theme.textTheme.headline1),
                  SizedBox(height: 10),
                  PostInfo(postModel: postModel),
                  SizedBox(height: 40),
                  Text(
                    postData.body,
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
