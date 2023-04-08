import 'package:calculadora_taxa/app/core/domain/entities/resultado_taxa_cartao_credito.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('resultado taxa cartao credito ...', () async {
    final result = ResultadoTaxaCartaoCredito(
      valorCobrado: 100,
      valorRecebido: 102,
      quantidadeParcela: 3,
      percentualTaxa: 1,
      percentualTaxaParcela: 1,
      valorAcrescimoParcelaTotal: 5.69,
    );

    expect(result.valorAcrescimoPorParcela, 1.90);
    expect(result.valorDaParcela, 35.23);
  });
}
