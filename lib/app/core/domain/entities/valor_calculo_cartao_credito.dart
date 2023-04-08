import 'package:calculadora_taxa/app/core/domain/entities/valor_calculo.dart';

///Infelizmente não consegui replicar o calculo para achar as taxas,
///então tive que chumbar os valores

const List<double> _taxaParceladoComprador = [
  5.26, // 2x
  7.06, // 3x
  8.87, // 4x
  10.71, // 5x
  12.56, // 6x
  14.44, // 7x
  16.33, // 8x
  18.25, // 9x
  20.18, // 10x
  22.13, // 11x
  24.11, // 12x
  26.10, // 13x
  28.11, // 14x
  30.14, // 15x
  32.20, // 16x
  34.27, // 17x
  36.36, // 18x
];

class ValorCalculoCartaoCredito extends ValorCalculo {
  final int quantidadeParcela;
  const ValorCalculoCartaoCredito({
    required super.valor,
    required super.tipoValorBase,
    required this.quantidadeParcela,
  }) : assert(
          quantidadeParcela >= 1 && quantidadeParcela <= 18,
          'quantidade de parcela não esta dentro do intervalo 1 a 18, '
          'atual: $quantidadeParcela',
        );

  bool get usarTaxaParcelada => quantidadeParcela > 1;

  double get taxaParcela {
    if (!usarTaxaParcelada) {
      return 0;
    }
    final indexTaxa = quantidadeParcela - 2;

    return _taxaParceladoComprador[indexTaxa] / 100;
  }

  @override
  List<Object> get props => [...super.props, quantidadeParcela];
}
