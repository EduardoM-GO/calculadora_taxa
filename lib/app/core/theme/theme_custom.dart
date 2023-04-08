import 'package:calculadora_taxa/app/core/theme/theme_text_styles.dart';
import 'package:flutter/material.dart';

ThemeData themeCustom({required ColorScheme colorScheme}) => ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      textTheme: TextTheme(
        displayLarge: ThemeTextStyles.headline1,
        displayMedium: ThemeTextStyles.headline2,
        displaySmall: ThemeTextStyles.headline3,
        headlineMedium: ThemeTextStyles.headline4,
        headlineSmall: ThemeTextStyles.headline5,
        titleLarge: ThemeTextStyles.headline6,
        titleMedium: ThemeTextStyles.subtitle1,
        titleSmall: ThemeTextStyles.subtitle2,
        bodyLarge: ThemeTextStyles.bodyText1,
        bodyMedium: ThemeTextStyles.bodyText2,
        labelLarge: ThemeTextStyles.button,
        bodySmall: ThemeTextStyles.caption,
        labelSmall: ThemeTextStyles.overline,
      ),
      inputDecorationTheme: const InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
      ),
      dividerTheme: const DividerThemeData(
        thickness: 0.2,
      ),
    );
