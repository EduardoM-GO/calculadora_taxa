import 'package:calculadora_taxa/app/core/domain/entities/resultado_taxa.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('resultado taxa - get valor taxa - valor positivo', () async {
    const result = ResultadoTaxa(
      valorRecebido: 100,
      valorCobrado: 120.50,
      percentualTaxa: 1,
    );
    expect(result.valorTaxa, 20.50);
  });
  test('resultado taxa - get valor taxa - valor negativo', () async {
    const result = ResultadoTaxa(
      valorRecebido: 120.50,
      valorCobrado: 100,
      percentualTaxa: 1,
    );
    expect(result.valorTaxa, -20.50);
  });

  test('resultado taxa - get valor taxa - valor zerado', () async {
    const result =
        ResultadoTaxa(valorRecebido: 0, valorCobrado: 0, percentualTaxa: 1);
    expect(result.valorTaxa, 0);
    const result2 =
        ResultadoTaxa(valorRecebido: 100, valorCobrado: 100, percentualTaxa: 1);
    expect(result2.valorTaxa, 0);
  });
}
