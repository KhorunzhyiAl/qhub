import 'package:flutter/material.dart';
import 'package:qhub/Domain/Feed/FeedQuery.dart';

class FeedWidget extends StatelessWidget {
  FeedQuery _feed;
  void Function(FeedQuery)? onSelected;

  FeedWidget(FeedQuery feed, {this.onSelected}) : _feed = feed;

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
                  child: Image.network(
                    'https://picsum.photos/200',
                    loadingBuilder: (_, __, ___) {
                      return Container(color: Colors.grey);
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
              Text(_feed.hubName),
            ],
          ),
        ),
      ),
    );
  }
}
