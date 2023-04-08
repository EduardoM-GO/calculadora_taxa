// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:calculadora_taxa/app/core/domain/entities/resultado_taxa.dart';
import 'package:calculadora_taxa/app/core/extensions/double_extension.dart';

class ResultadoTaxaCartaoCredito extends ResultadoTaxa {
  final double valorDaParcela;
  final int quantidadeParcela;
  final double valorAcrescimoPorParcela;
  final double valorAcrescimoParcelaTotal;
  final double percentualTaxaParcela;

  ResultadoTaxaCartaoCredito({
    required super.valorCobrado,
    required super.valorRecebido,
    required super.percentualTaxa,
    required this.quantidadeParcela,
    required this.valorAcrescimoParcelaTotal,
    required this.percentualTaxaParcela,
  })  : valorAcrescimoPorParcela =
            (valorAcrescimoParcelaTotal / quantidadeParcela).casasDecimas(2),
        valorDaParcela =
            ((valorCobrado + valorAcrescimoParcelaTotal) / quantidadeParcela)
                .casasDecimas(2);

  @override
  List<Object> get props => [
        ...super.props,
        valorCobrado,
        valorRecebido,
        valorDaParcela,
        quantidadeParcela,
        valorAcrescimoPorParcela,
        valorAcrescimoParcelaTotal
      ];
}
