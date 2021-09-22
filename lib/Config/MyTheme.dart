import 'package:flutter/material.dart';

class MyThemes {
  static const light = "light";
  static const dark = "dark";
}

class MyTheme with ChangeNotifier {
  var _currentThemeName = MyThemes.light;

  String get currentThemeName => _currentThemeName;

  ThemeData get currentTheme {
    switch (_currentThemeName) {
      case MyThemes.light:
        return light;
      case MyThemes.dark:
        return dark;
      default:
        return ThemeData();
    }
  }

  ThemeMode get currentThemeMode {
    switch (_currentThemeName) {
      case MyThemes.light:
        return ThemeMode.light;
      case MyThemes.dark:
        return ThemeMode.dark;
      default:
        return ThemeMode.dark;
    }
  }

  void toggleTheme() {
    switch (_currentThemeName) {
      case MyThemes.light:
        _currentThemeName = MyThemes.dark;
        break;
      case MyThemes.dark:
        _currentThemeName = MyThemes.light;
        break;
    }
    notifyListeners();
  }

  ThemeData light = ThemeData(
    shadowColor: Colors.black.withAlpha(150),
    splashColor: Colors.black.withAlpha(10),
    highlightColor: Colors.black.withAlpha(15),

    colorScheme: ColorScheme(
      primary: Colors.white,
      primaryVariant: Colors.grey.shade200,
      secondary: Colors.black,
      secondaryVariant: Colors.grey.shade700,
      surface: Colors.white,
      background: Colors.grey.shade100,
      error: Colors.white,
      onPrimary: Colors.grey.shade900,
      onSecondary: Colors.white,
      onBackground: Colors.grey.shade700,
      onSurface: Colors.black87,
      brightness: Brightness.light,
      onError: Colors.red,
    ),

    // Use for single line text input fields. I don't know the correct property for this.
    canvasColor: Colors.grey.shade200,

    cardTheme: CardTheme(
        color: Colors.white,
        elevation: 0,
        margin: EdgeInsets.symmetric(horizontal: 5, vertical: 3),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(2),
        )),

    outlinedButtonTheme: OutlinedButtonThemeData(
      style: ButtonStyle(
        textStyle: MaterialStateProperty.all(TextStyle(
          fontSize: 16,
        )),
        foregroundColor: MaterialStateProperty.all(Colors.black87),
        overlayColor: MaterialStateProperty.all(Colors.black.withAlpha(50)),
      ),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        animationDuration: Duration(milliseconds: 100),
        padding: MaterialStateProperty.all(EdgeInsets.all(15)),
        elevation: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.disabled)) {
            return 0;
          }
          return 10;
        }),
        backgroundColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.disabled)) {
            return Colors.grey.shade500;
          }
          return Colors.black;
        }),
        overlayColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.disabled)) {
            return Colors.transparent;
          }
          return Colors.white;
        }),
        foregroundColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.pressed)) {
            return Colors.black;
          }
          return Colors.white;
        }),
        textStyle: MaterialStateProperty.all(TextStyle(
          fontSize: 26,
          fontWeight: FontWeight.w500,
          letterSpacing: 2,
        )),
      ),
    ),

    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        alignment: Alignment.center,
        animationDuration: Duration(milliseconds: 100),
        foregroundColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.pressed)) {
            return Colors.grey.shade700;
          }
          return Colors.black;
        }),
        overlayColor: MaterialStateProperty.all<Color?>(Colors.black.withOpacity(0.15)),
        shape: MaterialStateProperty.all<OutlinedBorder>(ContinuousRectangleBorder()),
      ),
    ),

    // Todo: don't know how to set the text color to white when it's selected
    // (since the selection color is black)
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: Colors.black,
      selectionColor: Colors.black.withAlpha(50),
    ),

    textTheme: TextTheme(
      headline1: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.w900,
        color: Colors.black,
      ),
      headline2: TextStyle(
        fontSize: 25,
        fontWeight: FontWeight.w800,
        color: Colors.black,
      ),
      headline3: TextStyle(
        fontSize: 21,
        fontWeight: FontWeight.w700,
        color: Colors.black,
      ),
      headline4: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w700,
        color: Colors.black,
      ),
      headline5: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w700,
        color: Colors.black,
      ),
      headline6: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: Colors.black,
      ),
      bodyText1: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: Colors.black,
      ),
      bodyText2: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w400,
        color: Colors.black,
      ),
      caption: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w300,
        color: Colors.black87,
      ),
    ),
  );

  ThemeData dark = ThemeData(
    shadowColor: Colors.transparent,
    splashColor: Colors.white24,
    highlightColor: Colors.white12,

    colorScheme: ColorScheme(
      primary: Colors.black,
      primaryVariant: Colors.grey.shade900,
      secondary: Colors.grey.shade800,
      secondaryVariant: Colors.grey.shade700,
      surface: Colors.black,
      background: Color.fromARGB(255, 12, 12, 12),
      error: Colors.black,
      onPrimary: Colors.grey.shade100,
      onSecondary: Colors.white,
      onBackground: Colors.grey.shade100,
      onSurface: Colors.white70,
      brightness: Brightness.dark,
      onError: Colors.red,
    ),

    // Use for single line text input fields. I don't know the correct property for this.
    canvasColor: Colors.grey.shade700,

    cardTheme: CardTheme(
      color: Colors.black,
      elevation: 0,
      margin: EdgeInsets.symmetric(horizontal: 5, vertical: 3),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(2),
      ),
    ),

    outlinedButtonTheme: OutlinedButtonThemeData(
      style: ButtonStyle(
        textStyle: MaterialStateProperty.all(TextStyle(
          fontSize: 16,
        )),
        foregroundColor: MaterialStateProperty.all(Colors.white70),
        overlayColor: MaterialStateProperty.all(Colors.white.withAlpha(50)),
      ),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        animationDuration: Duration(milliseconds: 100),
        padding: MaterialStateProperty.all(EdgeInsets.all(15)),
        elevation: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.disabled)) {
            return 0;
          }
          return 10;
        }),
        backgroundColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.disabled)) {
            return Colors.grey.shade500;
          }
          return Colors.white70;
        }),
        overlayColor: MaterialStateProperty.all(Colors.black54),
        foregroundColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.pressed)) {
            return Colors.white;
          }
          return Colors.black;
        }),
        textStyle: MaterialStateProperty.all(TextStyle(
          fontSize: 26,
          fontWeight: FontWeight.w500,
          letterSpacing: 2,
        )),
      ),
    ),

    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        alignment: Alignment.center,
        animationDuration: Duration(milliseconds: 100),
        foregroundColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.pressed)) {
            return Colors.white60;
          }
          return Colors.white;
        }),
        overlayColor: MaterialStateProperty.all<Color?>(Colors.white.withOpacity(0.15)),
        shape: MaterialStateProperty.all<OutlinedBorder>(ContinuousRectangleBorder()),
      ),
    ),

    // Todo: don't know how to set the text color to white when it's selected
    // (since the selection color is black)
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: Colors.white,
      selectionColor: Colors.white.withAlpha(50),
    ),

    textTheme: TextTheme(
      headline1: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.w900,
        color: Colors.white,
      ),
      headline2: TextStyle(
        fontSize: 25,
        fontWeight: FontWeight.w800,
        color: Colors.white,
      ),
      headline3: TextStyle(
        fontSize: 21,
        fontWeight: FontWeight.w700,
        color: Colors.white,
      ),
      headline4: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w700,
        color: Colors.white,
      ),
      headline5: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w700,
        color: Colors.white,
      ),
      headline6: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: Colors.white,
      ),
      bodyText1: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
      bodyText2: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w400,
        color: Colors.white,
      ),
      caption: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w300,
        color: Colors.white70,
      ),
    ),
  );
}
