import 'package:flutter/material.dart';
import 'package:dartz/dartz.dart' as dartz;
import 'package:qhub/Domain/Feed/PostModel.dart';

import 'package:qhub/Domain/SubmitPost/PostFormModel.dart';
import 'package:qhub/Domain/Navigation/Routes.dart';
import 'package:qhub/Domain/Feed/FeedQuery.dart';
import 'package:qhub/Screens/CreatePostScreen/Other/AddImageWidget.dart';
import 'package:qhub/Screens/Widgets/ErrorText.dart';
import 'package:qhub/Screens/Widgets/OverlayLoading/OverlayLoading.dart';

class CreatePostScreen extends StatelessWidget {
  late final PostFormModel _postFormModel;
  final overlayLoadingController = OverlayLoadingController();

  CreatePostScreen({PostFormModel? postFormModel})
      : _postFormModel = postFormModel ?? PostFormModel();

  Future<void> submit(NavigatorState nav) async {
    overlayLoadingController.show();

    final postId = await _postFormModel.submit();
    postId.fold(
      () => null,
      (postId) {
        nav.pushReplacementNamed(
          Routes.post,
          arguments: PostModel.load(postId),
        );
      },
    );

    overlayLoadingController.hide();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final nav = Navigator.of(context);

    return Stack(
      children: [
        Scaffold(
          backgroundColor: theme.colorScheme.background,
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
                backgroundColor: theme.colorScheme.primary,
                foregroundColor: theme.colorScheme.onPrimary,
                backwardsCompatibility: false,
                leading: IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    nav.pop();
                  },
                ),
                title: ValueListenableBuilder<dartz.Option<String>>(
                  valueListenable: _postFormModel.community,
                  builder: (_, value, child) {
                    return OutlinedButton(
                      onPressed: () async {
                        final selected = await nav.pushNamed<FeedQuery>(Routes.selectFeed);
                        if (selected != null)
                          _postFormModel.community.value = dartz.Some(selected.hubName);
                      },
                      child: Row(
                        children: [
                          Text(value.fold(
                            () => 'Select a community',
                            (a) => a,
                          )),
                          Spacer(),
                          Icon(Icons.arrow_drop_down),
                        ],
                      ),
                    );
                  },
                ),
                actions: [
                  IconButton(
                    onPressed: () {
                      submit(Navigator.of(context));
                    },
                    icon: Icon(Icons.check),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.save),
                  ),
                ],
              ),
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    SizedBox(height: 5),
                    AddImageWidget(_postFormModel.imageUploader),
                    Card(
                      child: TextField(
                        style: theme.textTheme.headline2,
                        maxLines: null,
                        maxLength: 300,
                        decoration: InputDecoration(
                          hintText: 'Title',
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                        ),
                        onChanged: (t) {
                          _postFormModel.title.value = t;
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: ValueListenableBuilder<dartz.Option<String>>(
                        valueListenable: _postFormModel.titleError,
                        builder: (_, error, __) {
                          return ErrorText(error.fold(
                            () => null,
                            (a) => a,
                          ));
                        },
                      ),
                    ),
                    Card(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          minHeight: 300,
                        ),
                        child: TextField(
                          style: theme.textTheme.bodyText2,
                          maxLines: null,
                          decoration: InputDecoration(
                            hintText: 'Body',
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                          ),
                          onChanged: (t) {
                            _postFormModel.body.value = t;
                          },
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        OverlayLoading(
          controller: overlayLoadingController,
        ),
      ],
    );
  }
}
