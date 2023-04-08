import 'package:calculadora_taxa/app/core/domain/use_cases/calcular_taxa_cartao_credito_use_case.dart';
import 'package:calculadora_taxa/app/core/extensions/double_extension.dart';
import 'package:calculadora_taxa/app/core/mask/real_mask.dart';
import 'package:calculadora_taxa/app/feature/home/view/cartao_credito/store/cartao_credito_store.dart';
import 'package:calculadora_taxa/app/feature/widgets/list_view_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';

class CartaoCreditoView extends StatefulWidget {
  const CartaoCreditoView({Key? key}) : super(key: key);

  @override
  State<CartaoCreditoView> createState() => _CartaoCreditoViewState();
}

class _CartaoCreditoViewState extends State<CartaoCreditoView> {
  late final CartaoCreditoStore store;
  late final TextEditingController valorReceberController;
  late final TextEditingController valorCobrarController;
  late final TextEditingController percentualTaxaController;
  late final TextEditingController valorTaxaController;
  late final TextEditingController quantidadeParcelaController;

  late final RealMask realMask;
  @override
  void initState() {
    super.initState();
    store = CartaoCreditoStore(GetIt.I.get<CalcularTaxaCartaoCreditoUseCase>());
    valorReceberController = TextEditingController();
    valorCobrarController = TextEditingController();
    percentualTaxaController = TextEditingController();
    valorTaxaController = TextEditingController();
    quantidadeParcelaController = TextEditingController(text: '1x');
    realMask = RealMask();
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
      setState(() {});
    });
  }

  @override
  void dispose() {
    store.dispose();
    valorReceberController.dispose();
    valorCobrarController.dispose();
    percentualTaxaController.dispose();
    valorTaxaController.dispose();
    quantidadeParcelaController.dispose();
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
          DropdownButtonFormField<QuantidadeParcelas>(
            decoration: const InputDecoration(
              label: Text('Número de parcelas(1x - 18x)'),
            ),
            items: QuantidadeParcelas.values
                .map(
                  (e) => DropdownMenuItem(
                    value: e,
                    child: Text(
                      e.nome,
                      maxLines: 1,
                    ),
                  ),
                )
                .toList(),
            value: store.quantidadeParcela,
            onChanged: (value) {
              if (value != null) {
                store.quantidadeParcela = value;
              }
            },
          ),
          TextField(
            readOnly: true,
            controller: TextEditingController(
              text: realMask.addMask(store.valorAcrescimoParcelaTotal),
            ),
            decoration: InputDecoration(
              label: Text(
                'Parcelamento comprador: '
                '${(store.percentualTaxaParcela * 100).formatoPercentual}',
              ),
            ),
          ),
          TextField(
            readOnly: true,
            controller: TextEditingController(
              text: realMask.addMask(
                store.valorCobrar + store.valorAcrescimoParcelaTotal,
              ),
            ),
            decoration: InputDecoration(
              label: Text(
                'Valor final para o comprador:('
                '${realMask.addMask(store.valorCobrar)} + '
                '${realMask.addMask(store.valorAcrescimoParcelaTotal)})',
              ),
            ),
          ),
        ],
      );
}
