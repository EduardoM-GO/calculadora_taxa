import 'package:calculadora_taxa/app/feature/home/view/cartao_credito/view/cartao_credito_view.dart';
import 'package:calculadora_taxa/app/feature/home/view/cartao_debito/view/cartao_debito_view.dart';
import 'package:calculadora_taxa/app/feature/home/view/pix/view/pix_view.dart';
import 'package:calculadora_taxa/app/routes/route_name.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () => context.push(RouteName.configuracao.path),
              icon: const Icon(Icons.settings),
            )
          ],
          bottom: const TabBar(
            tabs: [
              Text('Pix'),
              Text('Debito'),
              Text('Credito'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            PixView(),
            CartaoDebitoView(),
            CartaoCreditoView(),
          ],
        ),
      ),
    );
  }
}
