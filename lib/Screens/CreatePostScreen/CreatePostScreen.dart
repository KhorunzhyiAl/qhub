import 'package:flutter/material.dart';
import 'package:qhub/Domain/Models/PostFormModel.dart';

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
              onPressed: () {},
            ),
            title: OutlinedButton(
              onPressed: () {
                
              },
              child: Row(
                children: [
                  Text('Select a community'),
                  Spacer(),
                  Icon(Icons.arrow_drop_down),
                ],
              ),
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
