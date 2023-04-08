import 'package:calculadora_taxa/app/core/domain/entities/valor_calculo.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('valor calculo ==', () async {
    expect(
      const ValorCalculo(valor: 100, tipoValorBase: TipoValorBase.cobrar).props,
      const ValorCalculo(valor: 100, tipoValorBase: TipoValorBase.cobrar).props,
    );
  });
}
