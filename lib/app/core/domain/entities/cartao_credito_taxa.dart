import 'package:calculadora_taxa/app/core/domain/entities/taxa.dart';

class CartaoCreditoTaxa extends Taxa {
  final double percentualTaxaParcelado;

  const CartaoCreditoTaxa({
    required super.percentualTaxa,
    required this.percentualTaxaParcelado,
  });

  @override
  List<Object> get props => [
        percentualTaxa,
        percentualTaxaParcelado,
      ];
}
