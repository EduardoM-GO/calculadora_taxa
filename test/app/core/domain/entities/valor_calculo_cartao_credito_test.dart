import 'package:calculadora_taxa/app/core/domain/entities/valor_calculo.dart';
import 'package:calculadora_taxa/app/core/domain/entities/valor_calculo_cartao_credito.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('valor calculo cartao credito - Verificação assert', () async {
    expect(
      () => ValorCalculoCartaoCredito(
        valor: 100,
        tipoValorBase: TipoValorBase.receber,
        quantidadeParcela: 0,
      ),
      throwsA(isA<AssertionError>()),
    );
    expect(
      () => ValorCalculoCartaoCredito(
        valor: 100,
        tipoValorBase: TipoValorBase.receber,
        quantidadeParcela: 19,
      ),
      throwsA(isA<AssertionError>()),
    );
  });
  test('valor calculo cartao credito - props', () async {
    expect(
      const ValorCalculoCartaoCredito(
        valor: 100,
        tipoValorBase: TipoValorBase.receber,
        quantidadeParcela: 1,
      ).props,
      const ValorCalculoCartaoCredito(
        valor: 100,
        tipoValorBase: TipoValorBase.receber,
        quantidadeParcela: 1,
      ).props,
    );
  });
}
