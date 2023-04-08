import 'package:calculadora_taxa/app/core/domain/use_cases/calcular_taxa_cartao_debito_use_case.dart';
import 'package:calculadora_taxa/app/core/extensions/double_extension.dart';
import 'package:calculadora_taxa/app/core/mask/real_mask.dart';
import 'package:calculadora_taxa/app/feature/home/view/cartao_debito/store/cartao_debito_store.dart';
import 'package:calculadora_taxa/app/feature/widgets/list_view_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';

class CartaoDebitoView extends StatefulWidget {
  const CartaoDebitoView({Key? key}) : super(key: key);

  @override
  State<CartaoDebitoView> createState() => _CartaoDebitoViewState();
}

class _CartaoDebitoViewState extends State<CartaoDebitoView> {
  late final CartaoDebitoStore store;
  late final TextEditingController valorReceberController;
  late final TextEditingController valorCobrarController;
  late final TextEditingController percentualTaxaController;
  late final TextEditingController valorTaxaController;
  late final RealMask realMask;

  @override
  void initState() {
    super.initState();
    realMask = RealMask();
    store = CartaoDebitoStore(GetIt.I.get<CalcularTaxaCartaoDebitoUseCase>());
    valorReceberController = TextEditingController();
    valorCobrarController = TextEditingController();
    percentualTaxaController = TextEditingController();
    valorTaxaController = TextEditingController();
    store.addListener(() {
      final valorReceberString = realMask.addMask(store.valorReceber);
      if (valorReceberController.text != valorReceberString) {
        valorReceberController.text = valorReceberString;
      }
      final valorCobrarString = realMask.addMask(store.valorCobrar);
      if (valorCobrarController.text != valorCobrarString) {
        valorCobrarController.text = valorCobrarString;
      }
      percentualTaxaController.text = store.percentualTaxa.formatoPercentual;
      valorTaxaController.text = realMask.addMask(store.valorTaxa);
    });
  }

  @override
  void dispose() {
    store.dispose();
    valorReceberController.dispose();
    valorCobrarController.dispose();
    percentualTaxaController.dispose();
    valorTaxaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => ListViewWidget(
        children: [
          TextField(
            controller: valorCobrarController,
            decoration: const InputDecoration(
              label: Text('Se você cobrar'),
            ),
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'[\d]')),
              realMask
            ],
            onChanged: (value) => store.calculaValorReceber(
              valorCobrar: realMask.removerMask(value),
            ),
          ),
          TextField(
            controller: valorReceberController,
            decoration: const InputDecoration(
              label: Text('Irá receber'),
            ),
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'[\d]')),
              realMask
            ],
            onChanged: (value) => store.calculaValorCobrar(
              valorReceber: realMask.removerMask(value),
            ),
          ),
          TextField(
            readOnly: true,
            decoration: const InputDecoration(
              label: Text('Taxa (%)'),
            ),
            controller: percentualTaxaController,
          ),
          TextField(
            readOnly: true,
            decoration: const InputDecoration(
              label: Text('Valor Taxa'),
            ),
            controller: valorTaxaController,
          ),
        ],
      );
}
