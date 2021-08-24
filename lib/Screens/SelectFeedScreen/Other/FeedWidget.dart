import 'package:flutter/material.dart';
import 'package:qhub/Domain/Elements/Feed.dart';

class FeedWidget extends StatelessWidget {
  FeedParameters _feed;
  void Function(FeedParameters)? onSelected;

  FeedWidget(FeedParameters feed, {this.onSelected}) : _feed = feed;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          onSelected?.call(_feed);
        },
        child: Container(
          color: Colors.transparent,
          height: 50,
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Row(
            children: [
              AspectRatio(
                aspectRatio: 1,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(3),
                  child: Image.network('https://picsum.photos/200'),
                ),
              ),
              SizedBox(width: 15),
              Text(_feed.hubName),
            ],
          ),
        ),
      ),
    );
  }
}
