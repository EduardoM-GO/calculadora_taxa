import 'package:calculadora_taxa/app/core/domain/entities/taxa.dart';
import 'package:calculadora_taxa/app/core/domain/repositories/taxas_repository.dart';
import 'package:calculadora_taxa/app/core/domain/use_cases/get_pix_taxa_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:result_dart/functions.dart';
import 'package:result_dart/result_dart.dart';

class _TaxasRepositoryMock extends Mock implements TaxasRepository {}

void main() {
  late GetPixTaxaUseCase useCase;
  late TaxasRepository repository;
  late Taxa taxa;

  setUp(() {
    repository = _TaxasRepositoryMock();
    taxa = const Taxa(
      percentualTaxa: 1.5,
    );
    useCase = GetPixTaxaUseCaseImpl(repository);
  });
  test('get pix taxa use case - ok', () {
    when(() => repository.getTaxaPix()).thenReturn(Success(taxa));
    final result = useCase();

    expect(result.isSuccess(), true);
    expect(result.fold(id, id), isA<Taxa>());
    expect(result.fold(id, id), taxa);
  });
  test('get pix taxa use case - Erro', () {
    when(() => repository.getTaxaPix()).thenReturn(Failure(Exception()));
    final result = useCase();

    expect(result.isError(), true);
    expect(result.fold(id, id), isA<Exception>());
  });
}
