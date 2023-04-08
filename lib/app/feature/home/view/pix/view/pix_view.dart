import 'package:calculadora_taxa/app/core/domain/use_cases/calcular_taxa_pix_use_case.dart';
import 'package:calculadora_taxa/app/feature/home/view/pix/store/pix_store.dart';
import 'package:calculadora_taxa/app/feature/widgets/list_view_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';

class PixView extends StatefulWidget {
  const PixView({Key? key}) : super(key: key);

  @override
  State<PixView> createState() => _PixViewState();
}

class _PixViewState extends State<PixView> {
  late final PixStore store;
  late final TextEditingController valorReceberController;
  late final TextEditingController valorCobrarController;

  @override
  void initState() {
    super.initState();
    store = PixStore(GetIt.I.get<CalcularTaxaPixUseCase>());
    valorReceberController = TextEditingController(text: '');
    valorCobrarController = TextEditingController(text: '');
    store.addListener(() {
      final valorReceberString = store.valorReceber.toString();
      if (valorReceberController.text != valorReceberString) {
        valorReceberController.text = valorReceberString;
      }
      final valorCobrarString = store.valorCobrar.toString();
      if (valorCobrarController.text != valorCobrarString) {
        valorCobrarController.text = valorCobrarString;
      }
    });
  }

  @override
  void dispose() {
    store.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListViewWidget(
      children: [
        TextField(
          controller: valorReceberController,
          decoration: const InputDecoration(
            label: Text('Valor Receber'),
          ),
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'[\d,]'))
          ],
          onChanged: (value) => store.calculaValorCobrar(
            valorReceber: double.tryParse(value.replaceAll(',', '.')) ?? 0,
          ),
        ),
        TextField(
          controller: valorCobrarController,
          decoration: const InputDecoration(
            label: Text('Valor Cobrar'),
          ),
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'[\d,]'))
          ],
          onChanged: (value) => store.calculaValorReceber(
            valorCobrar: double.tryParse(value.replaceAll(',', '.')) ?? 0,
          ),
        ),
        AnimatedBuilder(
          animation: store,
          builder: (context, child) => TextField(
            readOnly: true,
            decoration: const InputDecoration(
              label: Text('Taxa (%)'),
            ),
            controller:
                TextEditingController(text: store.percentualTaxa.toString()),
          ),
        ),
        AnimatedBuilder(
          animation: store,
          builder: (context, child) => TextField(
            readOnly: true,
            decoration: const InputDecoration(
              label: Text('Taxa'),
            ),
            controller: TextEditingController(text: store.valorTaxa.toString()),
          ),
        ),
      ],
    );
  }
}
