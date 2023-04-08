import 'package:calculadora_taxa/app/core/domain/use_cases/set_taxas_use_case.dart';
import 'package:calculadora_taxa/app/core/mask/percentual_mask.dart';
import 'package:calculadora_taxa/app/feature/configuracao/store/configuracao_store.dart';
import 'package:calculadora_taxa/app/feature/widgets/dialogs_widget.dart';
import 'package:calculadora_taxa/app/feature/widgets/list_view_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

class ConfiguracaoView extends StatefulWidget {
  const ConfiguracaoView({Key? key}) : super(key: key);

  @override
  State<ConfiguracaoView> createState() => _ConfiguracaoViewState();
}

class _ConfiguracaoViewState extends State<ConfiguracaoView> {
  late final ConfiguracaoStore store;
  late final TextEditingController cartaoCreditoTaxaController;
  late final TextEditingController cartaoCreditoTaxaParceladoController;
  late final TextEditingController cartaoDebitoTaxaController;
  late final TextEditingController pixTaxaController;

  @override
  void initState() {
    super.initState();
    cartaoCreditoTaxaController = TextEditingController(text: '0.00%');
    cartaoCreditoTaxaParceladoController = TextEditingController(text: '0.00%');
    cartaoDebitoTaxaController = TextEditingController(text: '0.00%');
    pixTaxaController = TextEditingController(text: '0.00%');
    store = ConfiguracaoStore(GetIt.I.get<SetTaxasUseCase>());

    store.addListener(() {
      final value = store.value;
      if (value is ConfiguracaoLoadingState) {
        DialogsWidget.loading(context: context, title: 'Salvando ...');
      } else if (value is ConfiguracaoSuccessState) {
        context
          ..pop()
          ..pop();
      } else if (value is ConfiguracaoFailureState) {
        context.pop();
        DialogsWidget.warning(context: context, message: value.erro);
      }
    });
  }

  @override
  void dispose() {
    cartaoCreditoTaxaController.dispose();
    cartaoCreditoTaxaParceladoController.dispose();
    cartaoDebitoTaxaController.dispose();
    pixTaxaController.dispose();
    store.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Configuração Taxa'),
        actions: [
          IconButton(
            onPressed: () {
              store.salvar(
                cartaoCreditoTaxa: double.tryParse(
                      cartaoCreditoTaxaController.text.replaceAll(',', '.'),
                    ) ??
                    0,
                cartaoCreditoTaxaParcelado: double.tryParse(
                      cartaoCreditoTaxaParceladoController.text
                          .replaceAll(',', '.'),
                    ) ??
                    0,
                cartaoDebitoTaxa: double.tryParse(
                      cartaoDebitoTaxaController.text.replaceAll(',', '.'),
                    ) ??
                    0,
                pixTaxa: double.tryParse(
                      pixTaxaController.text.replaceAll(',', '.'),
                    ) ??
                    0,
              );
            },
            icon: const Icon(Icons.save),
          )
        ],
      ),
      body: ListViewWidget(
        children: [
          TextField(
            controller: cartaoCreditoTaxaController,
            decoration: const InputDecoration(
              label: Text('Cartão Crédito Taxa - À vista'),
            ),
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'[\d,]')),
              PercentualMask()
            ],
          ),
          TextField(
            controller: cartaoCreditoTaxaParceladoController,
            decoration: const InputDecoration(
              label: Text('Cartão Crédito Taxa - Parcelado'),
            ),
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'[\d,]')),
              PercentualMask()
            ],
          ),
          TextField(
            controller: cartaoDebitoTaxaController,
            decoration: const InputDecoration(
              label: Text('Cartão Débito Taxa'),
            ),
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'[\d,]')),
              PercentualMask()
            ],
          ),
          TextField(
            controller: pixTaxaController,
            decoration: const InputDecoration(
              label: Text('Pix Taxa'),
            ),
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'[\d,]')),
              PercentualMask()
            ],
          ),
        ],
      ),
    );
  }
}
