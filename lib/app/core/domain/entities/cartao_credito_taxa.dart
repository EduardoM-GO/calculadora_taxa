import 'package:calculadora_taxa/app/core/domain/entities/taxa.dart';

class CartaoCreditoTaxa extends Taxa {
  final double percentualTaxaParcelado;
  final double percentualTaxaPorParcela;

  const CartaoCreditoTaxa({
    required super.percentualTaxa,
    required this.percentualTaxaParcelado,
    required this.percentualTaxaPorParcela,
  });

  const CartaoCreditoTaxa.empty()
      : percentualTaxaParcelado = 0,
        percentualTaxaPorParcela = 0,
        super(percentualTaxa: 0);

  @override
  List<Object> get props => [
        percentualTaxa,
        percentualTaxaParcelado,
        percentualTaxaPorParcela,
      ];
}
