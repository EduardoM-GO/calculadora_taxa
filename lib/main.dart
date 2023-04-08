import 'package:calculadora_taxa/app/core/theme/color_schemes.g.dart';
import 'package:calculadora_taxa/app/core/theme/theme_custom.dart';
import 'package:calculadora_taxa/app/routes/router.dart';
import 'package:calculadora_taxa/injecao_dependencia.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await InjecaoDependencia.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: MaterialApp.router(
        theme: themeCustom(colorScheme: lightColorScheme),
        darkTheme: themeCustom(colorScheme: darkColorScheme),
        title: 'Calculadora Taxa',
        routerConfig: router,
      ),
    );
  }
}
