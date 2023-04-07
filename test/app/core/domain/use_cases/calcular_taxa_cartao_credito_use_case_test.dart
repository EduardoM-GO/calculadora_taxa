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
      percentualTaxaPorParcela: 2.99,
    );
  });

  group('calcular taxa cartao credito use case  - Valor Cobrado -', () {
    setUp(
      () => when(() => repository.getTaxaCartaoCredito())
          .thenReturn(Success(cartaoCreditoTaxa)),
    );

    group('Parcelado em uma vez', () {
      const quantidadeParcela = 1;
      test('100', () async {
        final result = useCase(
          valorCalculo: const ValorCalculoCartaoCredito(
            valor: 100,
            tipoValorBase: TipoValorBase.cobrar,
            quantidadeParcela: quantidadeParcela,
          ),
        );

        expect(result.isSuccess(), true);
        expect(
          result.fold(id, id),
          ResultadoTaxaCartaoCredito(
            valorRecebido: 96.81,
            valorCobrado: 100,
            quantidadeParcela: quantidadeParcela,
            valorAcrescimoParcelaTotal: 0,
          ),
        );
      });
      test('200', () async {
        final result = useCase(
          valorCalculo: const ValorCalculoCartaoCredito(
            valor: 200,
            tipoValorBase: TipoValorBase.cobrar,
            quantidadeParcela: quantidadeParcela,
          ),
        );

        expect(result.isSuccess(), true);
        expect(
          result.fold(id, id),
          ResultadoTaxaCartaoCredito(
            valorRecebido: 193.62,
            valorCobrado: 200,
            quantidadeParcela: quantidadeParcela,
            valorAcrescimoParcelaTotal: 0,
          ),
        );
      });
      test('259.69', () async {
        final result = useCase(
          valorCalculo: const ValorCalculoCartaoCredito(
            valor: 259.69,
            tipoValorBase: TipoValorBase.cobrar,
            quantidadeParcela: quantidadeParcela,
          ),
        );

        expect(result.isSuccess(), true);
        expect(
          result.fold(id, id),
          ResultadoTaxaCartaoCredito(
            valorRecebido: 251.41,
            valorCobrado: 259.69,
            quantidadeParcela: quantidadeParcela,
            valorAcrescimoParcelaTotal: 0,
          ),
        );
      });
    });

    group('Parcelado em duas vezes', () {
      const quantidadeParcela = 2;
      test('100', () async {
        final result = useCase(
          valorCalculo: const ValorCalculoCartaoCredito(
            valor: 100,
            tipoValorBase: TipoValorBase.cobrar,
            quantidadeParcela: quantidadeParcela,
          ),
        );

        expect(result.isSuccess(), true);
        expect(
          result.fold(id, id),
          ResultadoTaxaCartaoCredito(
            valorRecebido: 96.81,
            valorCobrado: 100,
            quantidadeParcela: quantidadeParcela,
            valorAcrescimoParcelaTotal: 0,
          ),
        );
      });
      test('200', () async {
        final result = useCase(
          valorCalculo: const ValorCalculoCartaoCredito(
            valor: 200,
            tipoValorBase: TipoValorBase.cobrar,
            quantidadeParcela: quantidadeParcela,
          ),
        );

        expect(result.isSuccess(), true);
        expect(
          result.fold(id, id),
          ResultadoTaxaCartaoCredito(
            valorRecebido: 193.62,
            valorCobrado: 200,
            quantidadeParcela: quantidadeParcela,
            valorAcrescimoParcelaTotal: 0,
          ),
        );
      });
      test('259.69', () async {
        final result = useCase(
          valorCalculo: const ValorCalculoCartaoCredito(
            valor: 259.69,
            tipoValorBase: TipoValorBase.cobrar,
            quantidadeParcela: quantidadeParcela,
          ),
        );

        expect(result.isSuccess(), true);
        expect(
          result.fold(id, id),
          ResultadoTaxaCartaoCredito(
            valorRecebido: 249.85,
            valorCobrado: 259.69,
            quantidadeParcela: quantidadeParcela,
            valorAcrescimoParcelaTotal: 13.66,
          ),
        );
      });
    });
  });
/*
  group('calcular taxa cartao credito use case  - Valor receber -', () {
    setUp(
      () => when(() => repository.getTaxaCartaoCredito())
          .thenReturn(const Success(Taxa(percentualTaxa: 2.39))),
    );
    test('100', () async {
      final result = useCase(
        valorCalculo: const ValorCalculo(
          valor: 100,
          tipoValorBase: TipoValorBase.receber,
        ),
      );

      expect(result.isSuccess(), true);
      expect(
        result.fold(id, id),
        const ResultadoTaxa(valorRecebido: 100, valorCobrado: 102.45),
      );
    });
    test('200', () async {
      final result = useCase(
        valorCalculo: const ValorCalculo(
          valor: 200,
          tipoValorBase: TipoValorBase.receber,
        ),
      );

      expect(result.isSuccess(), true);
      expect(
        result.fold(id, id),
        const ResultadoTaxa(valorRecebido: 200, valorCobrado: 204.9),
      );
    });
    test('259.69', () async {
      final result = useCase(
        valorCalculo: const ValorCalculo(
          valor: 259.69,
          tipoValorBase: TipoValorBase.receber,
        ),
      );

      expect(result.isSuccess(), true);
      expect(
        result.fold(id, id),
        const ResultadoTaxa(valorRecebido: 259.69, valorCobrado: 266.05),
      );
    });
  });

  test('calcular taxa cartao credito use case  - Erro', () {
    when(() => repository.getTaxaCartaoCredito())
        .thenReturn(Failure(Exception()));
    final result = useCase(
      valorCalculo: const ValorCalculo(
        valor: 259.69,
        tipoValorBase: TipoValorBase.cobrar,
      ),
    );
    expect(result.isError(), true);
    expect(result.fold(id, id), isA<Exception>());

    final resultReceber = useCase(
      valorCalculo: const ValorCalculo(
        valor: 259.69,
        tipoValorBase: TipoValorBase.receber,
      ),
    );

    expect(resultReceber.isError(), true);
    expect(resultReceber.fold(id, id), isA<Exception>());
  });*/
}
