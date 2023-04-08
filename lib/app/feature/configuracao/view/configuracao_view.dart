import 'package:calculadora_taxa/app/core/domain/use_cases/get_taxas_use_case.dart';
import 'package:calculadora_taxa/app/core/domain/use_cases/set_taxas_use_case.dart';
import 'package:calculadora_taxa/app/core/extensions/double_extension.dart';
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
  late final FocusNode cartaoCreditoTaxaFocus;
  late final FocusNode cartaoCreditoTaxaParceladoFocus;
  late final FocusNode cartaoDebitoTaxaFocus;
  late final FocusNode pixTaxaFocus;

  @override
  void initState() {
    super.initState();
    cartaoCreditoTaxaController = TextEditingController();
    cartaoCreditoTaxaParceladoController = TextEditingController();
    cartaoDebitoTaxaController = TextEditingController();
    pixTaxaController = TextEditingController();

    ///Focus
    cartaoCreditoTaxaFocus = FocusNode();
    cartaoCreditoTaxaParceladoFocus = FocusNode();
    cartaoDebitoTaxaFocus = FocusNode();
    pixTaxaFocus = FocusNode();

    store = ConfiguracaoStore(
      GetIt.I.get<SetTaxasUseCase>(),
      GetIt.I.get<GetTaxasUseCase>(),
    );
    store
      ..addListener(() {
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
        } else if (value is ConfiguracaoGetTaxaState) {
          pixTaxaController.text = value.pix.percentualTaxa.formatoPercentual;
          cartaoDebitoTaxaController.text =
              value.cartaoDebito.percentualTaxa.formatoPercentual;
          cartaoCreditoTaxaController.text =
              value.cartaoCredito.percentualTaxa.formatoPercentual;
          cartaoCreditoTaxaParceladoController.text =
              value.cartaoCredito.percentualTaxaParcelado.formatoPercentual;
        }
      })
      ..get();
  }

  @override
  void dispose() {
    cartaoCreditoTaxaController.dispose();
    cartaoCreditoTaxaParceladoController.dispose();
    cartaoDebitoTaxaController.dispose();
    pixTaxaController.dispose();
    cartaoCreditoTaxaFocus.dispose();
    cartaoCreditoTaxaParceladoFocus.dispose();
    cartaoDebitoTaxaFocus.dispose();
    pixTaxaFocus.dispose();
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
                      cartaoCreditoTaxaController.text.replaceAll('%', ''),
                    ) ??
                    0,
                cartaoCreditoTaxaParcelado: double.tryParse(
                      cartaoCreditoTaxaParceladoController.text
                          .replaceAll('%', ''),
                    ) ??
                    0,
                cartaoDebitoTaxa: double.tryParse(
                      cartaoDebitoTaxaController.text.replaceAll('%', ''),
                    ) ??
                    0,
                pixTaxa: double.tryParse(
                      pixTaxaController.text.replaceAll('%', ''),
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
            focusNode: cartaoCreditoTaxaFocus,
            textInputAction: TextInputAction.next,
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
            focusNode: cartaoCreditoTaxaParceladoFocus,
            textInputAction: TextInputAction.next,
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
            focusNode: cartaoDebitoTaxaFocus,
            textInputAction: TextInputAction.next,
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
            focusNode: pixTaxaFocus,
            textInputAction: TextInputAction.next,
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
