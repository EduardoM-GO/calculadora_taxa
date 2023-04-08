import 'package:calculadora_taxa/app/feature/configuracao/view/configuracao_view.dart';
import 'package:calculadora_taxa/app/feature/home/view/home_view.dart';
import 'package:calculadora_taxa/app/routes/route_name.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: RouteName.home.path,
      builder: (context, state) => const HomeView(),
    ),
    GoRoute(
      path: RouteName.configuracao.path,
      builder: (context, state) => const ConfiguracaoView(),
    ),
  ],
);
