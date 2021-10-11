import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qhub/domain/locators.dart';
import 'package:qhub/domain/core/client/client.dart';
import 'package:qhub/config/my_theme.dart';

class MyDrawer extends StatelessWidget {
  final client = locator<Client>();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Drawer(
      child: Container(
        color: theme.colorScheme.surface,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              height: 200,
              color: theme.colorScheme.background,
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              child: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: theme.colorScheme.onBackground.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                    Spacer(),
                    Container(
                      width: 150,
                      height: 18,
                      decoration: BoxDecoration(
                        color: theme.colorScheme.onBackground.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      width: 100,
                      height: 18,
                      decoration: BoxDecoration(
                        color: theme.colorScheme.onBackground.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            _DrawerOption(
              onPressed: () {
                client.logOut();
              },
              text: 'Log out',
              icon: Icons.logout,
            ),
            _DrawerOption(
              onPressed: () {},
              text: 'Settings',
              icon: Icons.settings,
            ),
            _ThemeSwitch(),
          ],
        ),
      ),
    );
  }
}

class _ThemeSwitch extends StatelessWidget {
  final themeControl = locator<MyTheme>();

  @override
  Widget build(BuildContext context) {
    return _DrawerOption(
      onPressed: () {
        themeControl.toggleTheme();
      },
      text: 'Theme: ' + themeControl.currentThemeName,
      icon: Icons.settings,
    );
  }
}

class _DrawerOption extends StatelessWidget {
  final void Function() onPressed;
  final String text;
  final IconData icon;

  _DrawerOption({
    required this.onPressed,
    required this.text,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return TextButton(
      onPressed: onPressed,
      style: theme.textButtonTheme.style,
      child: Row(
        children: [
          SizedBox(height: 50),
          Icon(icon),
          SizedBox(width: 10),
          Text(text, style: theme.textTheme.headline5),
          Spacer(),
        ],
      ),
    );
  }
}
