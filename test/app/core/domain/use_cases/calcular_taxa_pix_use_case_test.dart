import 'package:calculadora_taxa/app/core/domain/entities/resultado_taxa.dart';
import 'package:calculadora_taxa/app/core/domain/entities/taxa.dart';
import 'package:calculadora_taxa/app/core/domain/entities/valor_calculo.dart';
import 'package:calculadora_taxa/app/core/domain/repositories/taxas_repository.dart';
import 'package:calculadora_taxa/app/core/domain/use_cases/calcular_taxa_pix_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:result_dart/functions.dart';
import 'package:result_dart/result_dart.dart';

class _TaxasRepositoryMock extends Mock implements TaxasRepository {}

void main() {
  late TaxasRepository repository;
  late CalcularTaxaPixUseCase useCase;

  setUp(() {
    repository = _TaxasRepositoryMock();
    useCase = CalcularTaxaPixUseCaseImpl(repository);
  });

  group('calcular taxa pix use case - Valor Cobrado -', () {
    setUp(
      () => when(() => repository.getTaxaPix())
          .thenReturn(const Success(Taxa(percentualTaxa: 0.99))),
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
          valorRecebido: 99.01,
          valorCobrado: 100,
          percentualTaxa: 0.99,
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
          valorRecebido: 198.02,
          valorCobrado: 200,
          percentualTaxa: 0.99,
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
          valorRecebido: 257.12,
          valorCobrado: 259.69,
          percentualTaxa: 0.99,
        ),
      );
    });
  });

  group('calcular taxa pix use case - Valor receber -', () {
    setUp(
      () => when(() => repository.getTaxaPix())
          .thenReturn(const Success(Taxa(percentualTaxa: 0.99))),
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
          valorCobrado: 101,
          percentualTaxa: 0.99,
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
          valorCobrado: 202,
          percentualTaxa: 0.99,
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
          valorCobrado: 262.29,
          percentualTaxa: 0.99,
        ),
      );
    });
  });

  test('calcular taxa pix use case - Erro', () {
    when(() => repository.getTaxaPix()).thenReturn(Failure(Exception()));
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
