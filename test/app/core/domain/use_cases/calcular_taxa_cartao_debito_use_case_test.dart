import 'package:calculadora_taxa/app/core/domain/entities/resultado_taxa.dart';
import 'package:calculadora_taxa/app/core/domain/entities/taxa.dart';
import 'package:calculadora_taxa/app/core/domain/entities/valor_calculo.dart';
import 'package:calculadora_taxa/app/core/domain/repositories/taxas_repository.dart';
import 'package:calculadora_taxa/app/core/domain/use_cases/calcular_taxa_cartao_debito_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:result_dart/functions.dart';
import 'package:result_dart/result_dart.dart';

class _TaxasRepositoryMock extends Mock implements TaxasRepository {}

void main() {
  late TaxasRepository repository;
  late CalcularTaxaCartaoDebitoUseCase useCase;

  setUp(() {
    repository = _TaxasRepositoryMock();
    useCase = CalcularTaxaCartaoDebitoUseCaseImpl(repository);
  });

  group('calcular taxa pix use case - Valor Cobrado -', () {
    setUp(
      () => when(() => repository.getTaxaCartaoDebito())
          .thenReturn(const Success(Taxa(percentualTaxa: 2.39))),
    );
    test('100', () async {
      final result = useCase(
        valorCalculo:
            const ValorCalculo(valor: 100, tipoValorBase: TipoValorBase.cobrar),
      );

      expect(result.isSuccess(), true);
      expect(
        result.fold(id, id),
        const ResultadoTaxa(
          valorRecebido: 97.61,
          valorCobrado: 100,
          percentualTaxa: 2.39,
        ),
      );
    });
    test('200', () async {
      final result = useCase(
        valorCalculo:
            const ValorCalculo(valor: 200, tipoValorBase: TipoValorBase.cobrar),
      );

      expect(result.isSuccess(), true);
      expect(
        result.fold(id, id),
        const ResultadoTaxa(
          valorRecebido: 195.22,
          valorCobrado: 200,
          percentualTaxa: 2.39,
        ),
      );
    });
    test('259.69', () async {
      final result = useCase(
        valorCalculo: const ValorCalculo(
          valor: 259.69,
          tipoValorBase: TipoValorBase.cobrar,
        ),
      );

      expect(result.isSuccess(), true);
      expect(
        result.fold(id, id),
        const ResultadoTaxa(
          valorRecebido: 253.48,
          valorCobrado: 259.69,
          percentualTaxa: 2.39,
        ),
      );
    });
  });

  group('calcular taxa pix use case - Valor receber -', () {
    setUp(
      () => when(() => repository.getTaxaCartaoDebito())
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
        const ResultadoTaxa(
          valorRecebido: 100,
          valorCobrado: 102.45,
          percentualTaxa: 2.39,
        ),
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
        const ResultadoTaxa(
          valorRecebido: 200,
          valorCobrado: 204.9,
          percentualTaxa: 2.39,
        ),
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
        const ResultadoTaxa(
          valorRecebido: 259.69,
          valorCobrado: 266.05,
          percentualTaxa: 2.39,
        ),
      );
    });
  });

  test('calcular taxa pix use case - Erro', () {
    when(() => repository.getTaxaCartaoDebito())
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
  });
}
