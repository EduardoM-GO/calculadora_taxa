import 'package:calculadora_taxa/app/core/domain/entities/taxa.dart';
import 'package:calculadora_taxa/app/core/domain/repositories/taxas_repository.dart';
import 'package:result_dart/result_dart.dart';

abstract class GetCartaoDebitoTaxaUseCase {
  Result<Taxa, Exception> call();
}

class GetCartaoDebitoTaxaUseCaseImpl extends GetCartaoDebitoTaxaUseCase {
  final TaxasRepository _repository;

  GetCartaoDebitoTaxaUseCaseImpl(this._repository);
  @override
  Result<Taxa, Exception> call() => _repository.getTaxaCartaoDebito();
}
