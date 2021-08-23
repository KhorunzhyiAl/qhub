import 'package:flutter/material.dart';

class MyTheme with ChangeNotifier {
  var _isLightTheme = true;

  ThemeMode get currentMode => _isLightTheme ? ThemeMode.light : ThemeMode.dark;

  ThemeData get currentTheme {
    switch (currentMode) {
      case ThemeMode.light:
        return light;
      case ThemeMode.dark:
        return dark;
      default:
        return ThemeData();
    }
  }

  void toggleTheme() {
    _isLightTheme = !_isLightTheme;
    notifyListeners();
  }

  ThemeData get light => ThemeData(
        shadowColor: Colors.black.withAlpha(150),
        splashColor: Colors.black.withAlpha(10),
        highlightColor: Colors.black.withAlpha(15),

        colorScheme: ColorScheme(
          primary: Colors.grey.shade200,
          primaryVariant: Colors.white70,
          secondary: Colors.black,
          secondaryVariant: Colors.grey.shade700,
          surface: Colors.grey.shade100,
          background: Colors.white,
          error: Colors.white,
          onPrimary: Colors.grey.shade900,
          onSecondary: Colors.white,
          onBackground: Colors.black87,
          onSurface: Colors.black87,
          brightness: Brightness.light,
          onError: Colors.red,
        ),

        // Use for single line text input fields. I don't know the correct property for this.
        canvasColor: Colors.grey.shade200,
        
        cardTheme: CardTheme(
          color: Colors.grey.shade100,
          elevation: 0,
          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(3),
          )
        ),

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
              fontWeight: FontWeight.w300,
              letterSpacing: 5,
            )),
          ),
        ),
        
        textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
            alignment: Alignment.center,
            animationDuration: Duration(milliseconds: 100),
            foregroundColor: MaterialStateProperty.resolveWith((states) {
              if (states.contains(MaterialState.pressed)) {
                return Colors.black54;
              }
              return Colors.black;
            }),
            overlayColor: MaterialStateProperty.all<Color?>(Colors.transparent),
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
            fontSize: 32,
            fontWeight: FontWeight.w900,
            color: Colors.black,
          ),
          headline2: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w900,
            color: Colors.black,
          ),
          headline3: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
          headline4: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
          headline5: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
          headline6: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
          bodyText1: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w400,
            color: Colors.black,
          ),
          bodyText2: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w200,
            color: Colors.black87,
          ),
          caption: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w300,
            color: Colors.black87,
          ),
        ),
      );

  ThemeData get dark => ThemeData();
}
