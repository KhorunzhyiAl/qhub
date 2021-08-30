import 'package:flutter/material.dart';
import 'package:qhub/Domain/Feed/FeedQuery.dart';

class FeedWidget extends StatelessWidget {
  final FeedQuery _feed;
  final void Function(FeedQuery)? onSelected;

  FeedWidget(FeedQuery feed, {this.onSelected}) : _feed = feed;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      margin: EdgeInsets.symmetric(vertical: 2, horizontal: 5),
      child: InkWell(
        onTap: () {
          onSelected?.call(_feed);
        },
        child: Container(
          color: Colors.transparent,
          height: 40,
          padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
          child: Row(
            children: [
              AspectRatio(
                aspectRatio: 1,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(3),
                  child: Image.network(
                    'https://picsum.photos/200',
                    frameBuilder: (_, child, __, ___) {
                      return child;
                    },
                    loadingBuilder: (_, child, chunk) {
                      return Container(
                        color: Colors.grey,
                        child: child,
                      );
                    },
                    errorBuilder: (_, __, ___) {
                      return Container(
                        color: Colors.grey,
                        child: Icon(Icons.image, color: Colors.white),
                      );
                    },
                  ),
                ),
              ),
              SizedBox(width: 15),
              Text(_feed.hubName, style: theme.textTheme.headline6,),
            ],
          ),
        ),
      ),
    );
  }
}
