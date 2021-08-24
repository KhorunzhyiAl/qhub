import 'package:flutter/material.dart';
import 'package:qhub/Domain/Models/PostFormModel.dart';
import 'package:qhub/Domain/Navigation/Routes.dart';
import 'package:qhub/Domain/Elements/Feed.dart';
import 'package:qhub/Screens/SelectFeedScreen/SelectFeedScreen.dart';

class CreatePostScreen extends StatelessWidget {
  late final PostFormModel _postFormModel;

  CreatePostScreen({PostFormModel? postFormModel})
      : _postFormModel = postFormModel ?? PostFormModel();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final nav = Navigator.of(context);

    return Scaffold(
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
            title: ValueListenableBuilder<String?>(
              valueListenable: _postFormModel.communityValNotifier,
              builder: (_, value, child) {
                return OutlinedButton(
                  onPressed: () async {
                    final selected = await nav.pushNamed<FeedParameters>(Routes.selectFeed);
                    _postFormModel.community = selected?.hubName;
                  },
                  child: Row(
                    children: [
                      Text(value ?? 'Select a community'),
                      Spacer(),
                      Icon(Icons.arrow_drop_down),
                    ],
                  ),
                );
              },
            ),
            actions: [
              IconButton(
                onPressed: () {},
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
                Card(
                  child: TextField(
                    style: theme.textTheme.headline2,
                    maxLines: null,
                    maxLength: 300,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                    ),
                  ),
                ),
                Card(
                  child: TextField(
                    style: theme.textTheme.bodyText2,
                    maxLines: null,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
