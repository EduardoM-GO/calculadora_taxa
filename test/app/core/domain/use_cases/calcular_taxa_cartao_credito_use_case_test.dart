import 'package:calculadora_taxa/app/core/domain/entities/cartao_credito_taxa.dart';
import 'package:calculadora_taxa/app/core/domain/entities/resultado_taxa_cartao_credito.dart';
import 'package:calculadora_taxa/app/core/domain/entities/valor_calculo.dart';
import 'package:calculadora_taxa/app/core/domain/entities/valor_calculo_cartao_credito.dart';
import 'package:calculadora_taxa/app/core/domain/repositories/taxas_repository.dart';
import 'package:calculadora_taxa/app/core/domain/use_cases/calcular_taxa_cartao_credito_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:result_dart/functions.dart';
import 'package:result_dart/result_dart.dart';

class _TaxasRepositoryMock extends Mock implements TaxasRepository {}

void main() {
  late TaxasRepository repository;
  late CalcularTaxaCartaoCreditoUseCase useCase;
  late CartaoCreditoTaxa cartaoCreditoTaxa;

  setUp(() {
    repository = _TaxasRepositoryMock();
    useCase = CalcularTaxaCartaoCreditoUseCaseImpl(repository);
    cartaoCreditoTaxa = const CartaoCreditoTaxa(
      percentualTaxa: 3.19,
      percentualTaxaParcelado: 3.79,
    );
  });

  group('calcular taxa cartao credito use case - Valor Cobrado -', () {
    setUp(
      () => when(() => repository.getTaxaCartaoCredito())
          .thenReturn(Success(cartaoCreditoTaxa)),
    );

    group('Parcelado em uma vez', () {
      const quantidadeParcela = 1;
      test('100', () async {
        const valorCalculo = ValorCalculoCartaoCredito(
          valor: 100,
          tipoValorBase: TipoValorBase.cobrar,
          quantidadeParcela: quantidadeParcela,
        );
        final result = useCase(
          valorCalculo: valorCalculo,
        );

        expect(result.isSuccess(), true);
        expect(
          result.fold(id, id),
          ResultadoTaxaCartaoCredito(
            valorRecebido: 96.81,
            valorCobrado: 100,
            quantidadeParcela: quantidadeParcela,
            valorAcrescimoParcelaTotal: 0,
            percentualTaxa: cartaoCreditoTaxa.percentualTaxa,
            percentualTaxaParcela: valorCalculo.taxaParcela,
          ),
        );
      });
      test('200', () async {
        const valorCalculo = ValorCalculoCartaoCredito(
          valor: 200,
          tipoValorBase: TipoValorBase.cobrar,
          quantidadeParcela: quantidadeParcela,
        );
        final result = useCase(
          valorCalculo: valorCalculo,
        );

        expect(result.isSuccess(), true);
        expect(
          result.fold(id, id),
          ResultadoTaxaCartaoCredito(
            valorRecebido: 193.62,
            valorCobrado: 200,
            quantidadeParcela: quantidadeParcela,
            valorAcrescimoParcelaTotal: 0,
            percentualTaxa: cartaoCreditoTaxa.percentualTaxa,
            percentualTaxaParcela: valorCalculo.taxaParcela,
          ),
        );
      });
      test('259.69', () async {
        const valorCalculo = ValorCalculoCartaoCredito(
          valor: 259.69,
          tipoValorBase: TipoValorBase.cobrar,
          quantidadeParcela: quantidadeParcela,
        );
        final result = useCase(
          valorCalculo: valorCalculo,
        );

        expect(result.isSuccess(), true);
        expect(
          result.fold(id, id),
          ResultadoTaxaCartaoCredito(
            valorRecebido: 251.41,
            valorCobrado: 259.69,
            quantidadeParcela: quantidadeParcela,
            valorAcrescimoParcelaTotal: 0,
            percentualTaxa: cartaoCreditoTaxa.percentualTaxa,
            percentualTaxaParcela: valorCalculo.taxaParcela,
          ),
        );
      });
    });

    group('calcular taxa cartao credito use case - Parcelado - valor: 259.69 -',
        () {
      test('3x', () async {
        const quantidadeParcela = 3;

        const valorCalculo = ValorCalculoCartaoCredito(
          valor: 259.69,
          tipoValorBase: TipoValorBase.cobrar,
          quantidadeParcela: quantidadeParcela,
        );
        final result = useCase(
          valorCalculo: valorCalculo,
        );

        expect(result.isSuccess(), true);
        expect(
          result.fold(id, id),
          ResultadoTaxaCartaoCredito(
            valorRecebido: 249.85,
            valorCobrado: 259.69,
            quantidadeParcela: quantidadeParcela,
            valorAcrescimoParcelaTotal: 18.33,
            percentualTaxa: cartaoCreditoTaxa.percentualTaxaParcelado,
            percentualTaxaParcela: valorCalculo.taxaParcela,
          ),
        );
      });
      test('4x', () async {
        const quantidadeParcela = 4;
        const valorCalculo = ValorCalculoCartaoCredito(
          valor: 259.69,
          tipoValorBase: TipoValorBase.cobrar,
          quantidadeParcela: quantidadeParcela,
        );
        final result = useCase(
          valorCalculo: valorCalculo,
        );
        expect(result.isSuccess(), true);
        expect(
          result.fold(id, id),
          ResultadoTaxaCartaoCredito(
            valorRecebido: 249.85,
            valorCobrado: 259.69,
            quantidadeParcela: quantidadeParcela,
            valorAcrescimoParcelaTotal: 23.03,
            percentualTaxa: cartaoCreditoTaxa.percentualTaxaParcelado,
            percentualTaxaParcela: valorCalculo.taxaParcela,
          ),
        );
      });
      test('5x', () async {
        const quantidadeParcela = 5;
        const valorCalculo = ValorCalculoCartaoCredito(
          valor: 259.69,
          tipoValorBase: TipoValorBase.cobrar,
          quantidadeParcela: quantidadeParcela,
        );
        final result = useCase(
          valorCalculo: valorCalculo,
        );

        expect(result.isSuccess(), true);
        expect(
          result.fold(id, id),
          ResultadoTaxaCartaoCredito(
            valorRecebido: 249.85,
            valorCobrado: 259.69,
            quantidadeParcela: quantidadeParcela,
            valorAcrescimoParcelaTotal: 27.81,
            percentualTaxa: cartaoCreditoTaxa.percentualTaxaParcelado,
            percentualTaxaParcela: valorCalculo.taxaParcela,
          ),
        );
      });
      test('6x', () async {
        const quantidadeParcela = 6;
        const valorCalculo = ValorCalculoCartaoCredito(
          valor: 259.69,
          tipoValorBase: TipoValorBase.cobrar,
          quantidadeParcela: quantidadeParcela,
        );
        final result = useCase(
          valorCalculo: valorCalculo,
        );

        expect(result.isSuccess(), true);
        expect(
          result.fold(id, id),
          ResultadoTaxaCartaoCredito(
            valorRecebido: 249.85,
            valorCobrado: 259.69,
            quantidadeParcela: quantidadeParcela,
            valorAcrescimoParcelaTotal: 32.62,
            percentualTaxa: cartaoCreditoTaxa.percentualTaxaParcelado,
            percentualTaxaParcela: valorCalculo.taxaParcela,
          ),
        );
      });
      test('7x', () async {
        const quantidadeParcela = 7;
        const valorCalculo = ValorCalculoCartaoCredito(
          valor: 259.69,
          tipoValorBase: TipoValorBase.cobrar,
          quantidadeParcela: quantidadeParcela,
        );
        final result = useCase(
          valorCalculo: valorCalculo,
        );

        expect(result.isSuccess(), true);
        expect(
          result.fold(id, id),
          ResultadoTaxaCartaoCredito(
            valorRecebido: 249.85,
            valorCobrado: 259.69,
            quantidadeParcela: quantidadeParcela,
            valorAcrescimoParcelaTotal: 37.50,
            percentualTaxa: cartaoCreditoTaxa.percentualTaxaParcelado,
            percentualTaxaParcela: valorCalculo.taxaParcela,
          ),
        );
      });
      test('8x', () async {
        const quantidadeParcela = 8;
        const valorCalculo = ValorCalculoCartaoCredito(
          valor: 259.69,
          tipoValorBase: TipoValorBase.cobrar,
          quantidadeParcela: quantidadeParcela,
        );
        final result = useCase(
          valorCalculo: valorCalculo,
        );

        expect(result.isSuccess(), true);
        expect(
          result.fold(id, id),
          ResultadoTaxaCartaoCredito(
            valorRecebido: 249.85,
            valorCobrado: 259.69,
            quantidadeParcela: quantidadeParcela,
            valorAcrescimoParcelaTotal: 42.41,
            percentualTaxa: cartaoCreditoTaxa.percentualTaxaParcelado,
            percentualTaxaParcela: valorCalculo.taxaParcela,
          ),
        );
      });
      test('9x', () async {
        const quantidadeParcela = 9;
        const valorCalculo = ValorCalculoCartaoCredito(
          valor: 259.69,
          tipoValorBase: TipoValorBase.cobrar,
          quantidadeParcela: quantidadeParcela,
        );
        final result = useCase(
          valorCalculo: valorCalculo,
        );

        expect(result.isSuccess(), true);
        expect(
          result.fold(id, id),
          ResultadoTaxaCartaoCredito(
            valorRecebido: 249.85,
            valorCobrado: 259.69,
            quantidadeParcela: quantidadeParcela,
            valorAcrescimoParcelaTotal: 47.39,
            percentualTaxa: cartaoCreditoTaxa.percentualTaxaParcelado,
            percentualTaxaParcela: valorCalculo.taxaParcela,
          ),
        );
      });
      test('10x', () async {
        const quantidadeParcela = 10;
        const valorCalculo = ValorCalculoCartaoCredito(
          valor: 259.69,
          tipoValorBase: TipoValorBase.cobrar,
          quantidadeParcela: quantidadeParcela,
        );
        final result = useCase(
          valorCalculo: valorCalculo,
        );

        expect(result.isSuccess(), true);
        expect(
          result.fold(id, id),
          ResultadoTaxaCartaoCredito(
            valorRecebido: 249.85,
            valorCobrado: 259.69,
            quantidadeParcela: quantidadeParcela,
            valorAcrescimoParcelaTotal: 52.41,
            percentualTaxa: cartaoCreditoTaxa.percentualTaxaParcelado,
            percentualTaxaParcela: valorCalculo.taxaParcela,
          ),
        );
      });
      test('11x', () async {
        const quantidadeParcela = 11;
        const valorCalculo = ValorCalculoCartaoCredito(
          valor: 259.69,
          tipoValorBase: TipoValorBase.cobrar,
          quantidadeParcela: quantidadeParcela,
        );
        final result = useCase(
          valorCalculo: valorCalculo,
        );
        expect(result.isSuccess(), true);
        expect(
          result.fold(id, id),
          ResultadoTaxaCartaoCredito(
            valorRecebido: 249.85,
            valorCobrado: 259.69,
            quantidadeParcela: quantidadeParcela,
            valorAcrescimoParcelaTotal: 57.47,
            percentualTaxa: cartaoCreditoTaxa.percentualTaxaParcelado,
            percentualTaxaParcela: valorCalculo.taxaParcela,
          ),
        );
      });
      test('12x', () async {
        const quantidadeParcela = 12;
        const valorCalculo = ValorCalculoCartaoCredito(
          valor: 259.69,
          tipoValorBase: TipoValorBase.cobrar,
          quantidadeParcela: quantidadeParcela,
        );
        final result = useCase(
          valorCalculo: valorCalculo,
        );

        expect(result.isSuccess(), true);
        expect(
          result.fold(id, id),
          ResultadoTaxaCartaoCredito(
            valorRecebido: 249.85,
            valorCobrado: 259.69,
            quantidadeParcela: quantidadeParcela,
            valorAcrescimoParcelaTotal: 62.61,
            percentualTaxa: cartaoCreditoTaxa.percentualTaxaParcelado,
            percentualTaxaParcela: valorCalculo.taxaParcela,
          ),
        );
      });
      test('13x', () async {
        const quantidadeParcela = 13;
        const valorCalculo = ValorCalculoCartaoCredito(
          valor: 259.69,
          tipoValorBase: TipoValorBase.cobrar,
          quantidadeParcela: quantidadeParcela,
        );
        final result = useCase(
          valorCalculo: valorCalculo,
        );

        expect(result.isSuccess(), true);
        expect(
          result.fold(id, id),
          ResultadoTaxaCartaoCredito(
            valorRecebido: 249.85,
            valorCobrado: 259.69,
            quantidadeParcela: quantidadeParcela,
            valorAcrescimoParcelaTotal: 67.78,
            percentualTaxa: cartaoCreditoTaxa.percentualTaxaParcelado,
            percentualTaxaParcela: valorCalculo.taxaParcela,
          ),
        );
      });
      test('14x', () async {
        const quantidadeParcela = 14;
        const valorCalculo = ValorCalculoCartaoCredito(
          valor: 259.69,
          tipoValorBase: TipoValorBase.cobrar,
          quantidadeParcela: quantidadeParcela,
        );
        final result = useCase(
          valorCalculo: valorCalculo,
        );

        expect(result.isSuccess(), true);
        expect(
          result.fold(id, id),
          ResultadoTaxaCartaoCredito(
            valorRecebido: 249.85,
            valorCobrado: 259.69,
            quantidadeParcela: quantidadeParcela,
            valorAcrescimoParcelaTotal: 73,
            percentualTaxa: cartaoCreditoTaxa.percentualTaxaParcelado,
            percentualTaxaParcela: valorCalculo.taxaParcela,
          ),
        );
      });
      test('15x', () async {
        const quantidadeParcela = 15;
        const valorCalculo = ValorCalculoCartaoCredito(
          valor: 259.69,
          tipoValorBase: TipoValorBase.cobrar,
          quantidadeParcela: quantidadeParcela,
        );
        final result = useCase(
          valorCalculo: valorCalculo,
        );

        expect(result.isSuccess(), true);
        expect(
          result.fold(id, id),
          ResultadoTaxaCartaoCredito(
            valorRecebido: 249.85,
            valorCobrado: 259.69,
            quantidadeParcela: quantidadeParcela,
            valorAcrescimoParcelaTotal: 78.27,
            percentualTaxa: cartaoCreditoTaxa.percentualTaxaParcelado,
            percentualTaxaParcela: valorCalculo.taxaParcela,
          ),
        );
      });
      test('16x', () async {
        const quantidadeParcela = 16;
        const valorCalculo = ValorCalculoCartaoCredito(
          valor: 259.69,
          tipoValorBase: TipoValorBase.cobrar,
          quantidadeParcela: quantidadeParcela,
        );
        final result = useCase(
          valorCalculo: valorCalculo,
        );

        expect(result.isSuccess(), true);
        expect(
          result.fold(id, id),
          ResultadoTaxaCartaoCredito(
            valorRecebido: 249.85,
            valorCobrado: 259.69,
            quantidadeParcela: quantidadeParcela,
            valorAcrescimoParcelaTotal: 83.62,
            percentualTaxa: cartaoCreditoTaxa.percentualTaxaParcelado,
            percentualTaxaParcela: valorCalculo.taxaParcela,
          ),
        );
      });
      test('17x', () async {
        const quantidadeParcela = 17;
        const valorCalculo = ValorCalculoCartaoCredito(
          valor: 259.69,
          tipoValorBase: TipoValorBase.cobrar,
          quantidadeParcela: quantidadeParcela,
        );
        final result = useCase(
          valorCalculo: valorCalculo,
        );

        expect(result.isSuccess(), true);
        expect(
          result.fold(id, id),
          ResultadoTaxaCartaoCredito(
            valorRecebido: 249.85,
            valorCobrado: 259.69,
            quantidadeParcela: quantidadeParcela,
            valorAcrescimoParcelaTotal: 89,
            percentualTaxa: cartaoCreditoTaxa.percentualTaxaParcelado,
            percentualTaxaParcela: valorCalculo.taxaParcela,
          ),
        );
      });
      test('18x', () async {
        const quantidadeParcela = 18;
        const valorCalculo = ValorCalculoCartaoCredito(
          valor: 259.69,
          tipoValorBase: TipoValorBase.cobrar,
          quantidadeParcela: quantidadeParcela,
        );
        final result = useCase(
          valorCalculo: valorCalculo,
        );

        expect(result.isSuccess(), true);
        expect(
          result.fold(id, id),
          ResultadoTaxaCartaoCredito(
            valorRecebido: 249.85,
            valorCobrado: 259.69,
            quantidadeParcela: quantidadeParcela,
            valorAcrescimoParcelaTotal: 94.42,
            percentualTaxa: cartaoCreditoTaxa.percentualTaxaParcelado,
            percentualTaxaParcela: valorCalculo.taxaParcela,
          ),
        );
      });
    });
    group('Parcelado em duas vezes', () {
      const quantidadeParcela = 2;
      test('100', () async {
        const valorCalculo = ValorCalculoCartaoCredito(
          valor: 100,
          tipoValorBase: TipoValorBase.cobrar,
          quantidadeParcela: quantidadeParcela,
        );
        final result = useCase(valorCalculo: valorCalculo);

        expect(result.isSuccess(), true);
        expect(
          result.fold(id, id),
          ResultadoTaxaCartaoCredito(
            valorRecebido: 96.21,
            valorCobrado: 100,
            quantidadeParcela: quantidadeParcela,
            valorAcrescimoParcelaTotal: 5.26,
            percentualTaxa: cartaoCreditoTaxa.percentualTaxaParcelado,
            percentualTaxaParcela: valorCalculo.taxaParcela,
          ),
        );
      });
      test('200', () async {
        const valorCalculo = ValorCalculoCartaoCredito(
          valor: 200,
          tipoValorBase: TipoValorBase.cobrar,
          quantidadeParcela: quantidadeParcela,
        );
        final result = useCase(valorCalculo: valorCalculo);

        expect(result.isSuccess(), true);
        expect(
          result.fold(id, id),
          ResultadoTaxaCartaoCredito(
            valorRecebido: 192.42,
            valorCobrado: 200,
            quantidadeParcela: quantidadeParcela,
            valorAcrescimoParcelaTotal: 10.52,
            percentualTaxa: cartaoCreditoTaxa.percentualTaxaParcelado,
            percentualTaxaParcela: valorCalculo.taxaParcela,
          ),
        );
      });
      test('259.69', () async {
        const valorCalculo = ValorCalculoCartaoCredito(
          valor: 259.69,
          tipoValorBase: TipoValorBase.cobrar,
          quantidadeParcela: quantidadeParcela,
        );
        final result = useCase(
          valorCalculo: valorCalculo,
        );

        expect(result.isSuccess(), true);
        expect(
          result.fold(id, id),
          ResultadoTaxaCartaoCredito(
            valorRecebido: 249.85,
            valorCobrado: 259.69,
            quantidadeParcela: quantidadeParcela,
            valorAcrescimoParcelaTotal: 13.66,
            percentualTaxa: cartaoCreditoTaxa.percentualTaxaParcelado,
            percentualTaxaParcela: valorCalculo.taxaParcela,
          ),
        );
      });
    });
  });
  group('calcular taxa cartao credito use case - Valor Receber -', () {
    setUp(
      () => when(() => repository.getTaxaCartaoCredito())
          .thenReturn(Success(cartaoCreditoTaxa)),
    );

    group('Parcelado em uma vez', () {
      const quantidadeParcela = 1;
      test('100', () async {
        const valorCalculo = ValorCalculoCartaoCredito(
          valor: 100,
          tipoValorBase: TipoValorBase.receber,
          quantidadeParcela: quantidadeParcela,
        );
        final result = useCase(
          valorCalculo: valorCalculo,
        );

        expect(result.isSuccess(), true);
        expect(
          result.fold(id, id),
          ResultadoTaxaCartaoCredito(
            valorRecebido: 100,
            valorCobrado: 103.30,
            quantidadeParcela: quantidadeParcela,
            valorAcrescimoParcelaTotal: 0,
            percentualTaxa: cartaoCreditoTaxa.percentualTaxa,
            percentualTaxaParcela: valorCalculo.taxaParcela,
          ),
        );
      });
      test('200', () async {
        const valorCalculo = ValorCalculoCartaoCredito(
          valor: 200,
          tipoValorBase: TipoValorBase.receber,
          quantidadeParcela: quantidadeParcela,
        );
        final result = useCase(
          valorCalculo: valorCalculo,
        );

        expect(result.isSuccess(), true);
        expect(
          result.fold(id, id),
          ResultadoTaxaCartaoCredito(
            valorRecebido: 200,
            valorCobrado: 206.59,
            quantidadeParcela: quantidadeParcela,
            valorAcrescimoParcelaTotal: 0,
            percentualTaxa: cartaoCreditoTaxa.percentualTaxa,
            percentualTaxaParcela: valorCalculo.taxaParcela,
          ),
        );
      });
      test('259.69', () async {
        const valorCalculo = ValorCalculoCartaoCredito(
          valor: 259.69,
          tipoValorBase: TipoValorBase.receber,
          quantidadeParcela: quantidadeParcela,
        );
        final result = useCase(
          valorCalculo: valorCalculo,
        );

        expect(result.isSuccess(), true);
        expect(
          result.fold(id, id),
          ResultadoTaxaCartaoCredito(
            valorRecebido: 259.69,
            valorCobrado: 268.25,
            quantidadeParcela: quantidadeParcela,
            valorAcrescimoParcelaTotal: 0,
            percentualTaxa: cartaoCreditoTaxa.percentualTaxa,
            percentualTaxaParcela: valorCalculo.taxaParcela,
          ),
        );
      });
    });
    group('Parcelado em duas vezes', () {
      const quantidadeParcela = 2;
      test('100', () async {
        const valorCalculo = ValorCalculoCartaoCredito(
          valor: 100,
          tipoValorBase: TipoValorBase.receber,
          quantidadeParcela: quantidadeParcela,
        );
        final result = useCase(
          valorCalculo: valorCalculo,
        );

        expect(result.isSuccess(), true);
        expect(
          result.fold(id, id),
          ResultadoTaxaCartaoCredito(
            valorRecebido: 100,
            valorCobrado: 103.94,
            quantidadeParcela: quantidadeParcela,
            valorAcrescimoParcelaTotal: 5.47,
            percentualTaxa: cartaoCreditoTaxa.percentualTaxaParcelado,
            percentualTaxaParcela: valorCalculo.taxaParcela,
          ),
        );
      });
      test('200', () async {
        const valorCalculo = ValorCalculoCartaoCredito(
          valor: 200,
          tipoValorBase: TipoValorBase.receber,
          quantidadeParcela: quantidadeParcela,
        );
        final result = useCase(
          valorCalculo: valorCalculo,
        );

        expect(result.isSuccess(), true);
        expect(
          result.fold(id, id),
          ResultadoTaxaCartaoCredito(
            valorRecebido: 200,
            valorCobrado: 207.88,
            quantidadeParcela: quantidadeParcela,
            valorAcrescimoParcelaTotal: 10.93,
            percentualTaxa: cartaoCreditoTaxa.percentualTaxaParcelado,
            percentualTaxaParcela: valorCalculo.taxaParcela,
          ),
        );
      });
      test('259.69', () async {
        const valorCalculo = ValorCalculoCartaoCredito(
          valor: 259.69,
          tipoValorBase: TipoValorBase.receber,
          quantidadeParcela: quantidadeParcela,
        );
        final result = useCase(
          valorCalculo: valorCalculo,
        );

        expect(result.isSuccess(), true);
        expect(
          result.fold(id, id),
          ResultadoTaxaCartaoCredito(
            valorRecebido: 259.69,
            valorCobrado: 269.92,
            quantidadeParcela: quantidadeParcela,
            valorAcrescimoParcelaTotal: 14.20,
            percentualTaxa: cartaoCreditoTaxa.percentualTaxaParcelado,
            percentualTaxaParcela: valorCalculo.taxaParcela,
          ),
        );
      });
    });
  });

  test('calcular taxa cartao credito use case  - Erro', () {
    when(() => repository.getTaxaCartaoCredito())
        .thenReturn(Failure(Exception()));
    final result = useCase(
      valorCalculo: const ValorCalculoCartaoCredito(
        valor: 259.69,
        tipoValorBase: TipoValorBase.cobrar,
        quantidadeParcela: 2,
      ),
    );
    expect(result.isError(), true);
    expect(result.fold(id, id), isA<Exception>());

    final resultReceber = useCase(
      valorCalculo: const ValorCalculoCartaoCredito(
        valor: 259.69,
        tipoValorBase: TipoValorBase.receber,
        quantidadeParcela: 2,
      ),
    );

    expect(resultReceber.isError(), true);
    expect(resultReceber.fold(id, id), isA<Exception>());
  });
}
