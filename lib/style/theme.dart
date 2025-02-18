import 'package:flutter/services.dart';

import 'color.dart';
import 'package:flutter/material.dart';

class MyTheme {
  static ThemeData standard() => ThemeData(
        useMaterial3: false,
        brightness: Brightness.light,
        hintColor: ColorPalette.mainGreen,
        pageTransitionsTheme: PageTransitionsTheme(
          builders: <TargetPlatform, PageTransitionsBuilder>{
            TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
            TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
            TargetPlatform.macOS: CupertinoPageTransitionsBuilder(),
          },
        ),
        appBarTheme: AppBarTheme(
          elevation: 0,
          color: ColorPalette.white,
          systemOverlayStyle: SystemUiOverlayStyle.dark,
          iconTheme: IconThemeData(
            color: ColorPalette.darkGray,
          ),
        ),
        primaryColor: ColorPalette.mainGreen,
        scaffoldBackgroundColor: ColorPalette.lightGray,
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: ColorPalette.mainGreen,
          selectionColor: ColorPalette.mainGreen.withOpacity(0.5),
          selectionHandleColor: ColorPalette.mainGreen,
        ),
        colorScheme: ColorScheme.fromSwatch()
            .copyWith(secondary: ColorPalette.mainGreen),
      );
}
