import 'package:flutter/material.dart';
import 'package:qhub/Config/MyTheme.dart';

class HomeScreen extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        shadowColor: theme.shadowColor,
        backgroundColor: theme.colorScheme.primary,
        leading: Container(
          alignment: Alignment.center,
          child: IconButton(
            onPressed: () {},
            icon: Icon(Icons.menu),
            color: theme.colorScheme.onPrimary,
          ),
        ),
        // title: ,
      ),
      body: Container(
        color: theme.colorScheme.background,
      ),
    );
  }
}
