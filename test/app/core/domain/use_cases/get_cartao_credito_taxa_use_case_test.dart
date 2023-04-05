import 'package:calculadora_taxa/app/core/domain/entities/cartao_credito_taxa.dart';
import 'package:calculadora_taxa/app/core/domain/repositories/taxas_repository.dart';
import 'package:calculadora_taxa/app/core/domain/use_cases/get_cartao_credito_taxa_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:result_dart/functions.dart';
import 'package:result_dart/result_dart.dart';

class _TaxasRepositoryMock extends Mock implements TaxasRepository {}

void main() {
  late GetCartaoCreditoTaxaUseCase useCase;
  late TaxasRepository repository;
  late CartaoCreditoTaxa cartaoCreditoTaxa;

  setUp(() {
    repository = _TaxasRepositoryMock();
    cartaoCreditoTaxa = const CartaoCreditoTaxa(
      percentualTaxa: 1,
      percentualTaxaParcelado: 2.8,
      percentualTaxaPorParcela: 3.6,
    );
    useCase = GetCartaoCreditoTaxaUseCaseImpl(repository);
  });
  test('get cartao credito taxa use case - ok', () {
    when(() => repository.getTaxaCartaoCredito())
        .thenReturn(Success(cartaoCreditoTaxa));
    final result = useCase();

    expect(result.isSuccess(), true);
    expect(result.fold(id, id), isA<CartaoCreditoTaxa>());
    expect(result.fold(id, id), cartaoCreditoTaxa);
  });
  test('get cartao credito taxa use case - Erro', () {
    when(() => repository.getTaxaCartaoCredito())
        .thenReturn(Failure(Exception()));
    final result = useCase();

    expect(result.isError(), true);
    expect(result.fold(id, id), isA<Exception>());

  });
}
