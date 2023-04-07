// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:calculadora_taxa/app/core/domain/entities/valor_calculo.dart';

class ValorCalculoCartaoCredito extends ValorCalculo {
  final int quantidadeParcela;
  const ValorCalculoCartaoCredito({
    required super.valor,
    required super.tipoValorBase,
    required this.quantidadeParcela,
  });

  bool get usarTaxaParcelada => quantidadeParcela > 1;

  @override
  List<Object> get props => [...super.props, quantidadeParcela];
}
