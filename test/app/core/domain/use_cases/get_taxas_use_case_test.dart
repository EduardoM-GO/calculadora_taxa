import 'package:calculadora_taxa/app/core/domain/entities/cartao_credito_taxa.dart';
import 'package:calculadora_taxa/app/core/domain/entities/taxa.dart';
import 'package:calculadora_taxa/app/core/domain/entities/taxas.dart';
import 'package:calculadora_taxa/app/core/domain/repositories/taxas_repository.dart';
import 'package:calculadora_taxa/app/core/domain/use_cases/get_taxas_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:result_dart/functions.dart';
import 'package:result_dart/result_dart.dart';

class _TaxasRepositoryMock extends Mock implements TaxasRepository {}

void main() {
  late TaxasRepository repository;
  late GetTaxasUseCase useCase;

  setUp(() {
    repository = _TaxasRepositoryMock();
    useCase = GetTaxasUseCaseImpl(repository);
  });

  test('get taxas use case - ok', () async {
    when(() => repository.getTaxaCartaoCredito()).thenReturn(
      const Success(
        CartaoCreditoTaxa(
          percentualTaxa: 3.7,
          percentualTaxaParcelado: 4.59,
        ),
      ),
    );
    when(() => repository.getTaxaCartaoDebito()).thenReturn(
      const Success(
        Taxa(percentualTaxa: 3.3),
      ),
    );
    when(() => repository.getTaxaPix()).thenReturn(
      const Success(Taxa(percentualTaxa: 2)),
    );

    final result = useCase();

    expect(result.isSuccess(), true);
    expect(
      result.fold(id, id),
      const Taxas(
        pix: Taxa(percentualTaxa: 2),
        cartaoDebito: Taxa(percentualTaxa: 3.3),
        cartaoCredito: CartaoCreditoTaxa(
          percentualTaxa: 3.7,
          percentualTaxaParcelado: 4.59,
        ),
      ),
    );
  });

  group('get taxas use case - erro -', () {
    test('getTaxaCartaoCredito', () async {
      when(() => repository.getTaxaCartaoCredito()).thenReturn(
        Failure(Exception()),
      );
      when(() => repository.getTaxaCartaoDebito()).thenReturn(
        const Success(
          Taxa(percentualTaxa: 3.3),
        ),
      );
      when(() => repository.getTaxaPix()).thenReturn(
        const Success(Taxa(percentualTaxa: 2)),
      );

      final result = useCase();

      expect(result.isError(), true);
      expect(result.fold(id, id), isA<Exception>());
    });
    test('getTaxaCartaoDebito', () async {
      when(() => repository.getTaxaCartaoCredito()).thenReturn(
        const Success(
          CartaoCreditoTaxa(
            percentualTaxa: 3.7,
            percentualTaxaParcelado: 4.59,
          ),
        ),
      );
      when(() => repository.getTaxaCartaoDebito()).thenReturn(
        Failure(Exception()),
      );
      when(() => repository.getTaxaPix()).thenReturn(
        const Success(Taxa(percentualTaxa: 2)),
      );

      final result = useCase();

      expect(result.isError(), true);
      expect(result.fold(id, id), isA<Exception>());
    });
    test('getTaxaPix', () async {
      when(() => repository.getTaxaCartaoCredito()).thenReturn(
        const Success(
          CartaoCreditoTaxa(
            percentualTaxa: 3.7,
            percentualTaxaParcelado: 4.59,
          ),
        ),
      );
      when(() => repository.getTaxaCartaoDebito()).thenReturn(
        const Success(
          Taxa(percentualTaxa: 3.3),
        ),
      );
      when(() => repository.getTaxaPix()).thenReturn(
        Failure(Exception()),
      );

      final result = useCase();

      expect(result.isError(), true);
      expect(result.fold(id, id), isA<Exception>());
    });
  });
}
