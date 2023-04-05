import 'package:calculadora_taxa/app/core/domain/entities/taxa.dart';
import 'package:calculadora_taxa/app/core/domain/repositories/taxas_repository.dart';
import 'package:result_dart/result_dart.dart';

abstract class GetPixTaxaUseCase {
  Result<Taxa, Exception> call();
}

class GetPixTaxaUseCaseImpl implements GetPixTaxaUseCase {
  final TaxasRepository _repository;

  GetPixTaxaUseCaseImpl(this._repository);
  @override
  Result<Taxa, Exception> call() => _repository.getTaxaPix();
}
