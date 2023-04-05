import 'package:calculadora_taxa/app/core/domain/entities/cartao_credito_taxa.dart';
import 'package:calculadora_taxa/app/core/domain/repositories/taxas_repository.dart';
import 'package:result_dart/result_dart.dart';

abstract class GetCartaoCreditoTaxaUseCase {
  Result<CartaoCreditoTaxa, Exception> call();
}

class GetCartaoCreditoTaxaUseCaseImpl implements GetCartaoCreditoTaxaUseCase {
  final TaxasRepository _repository;

  GetCartaoCreditoTaxaUseCaseImpl(this._repository);
  @override
  Result<CartaoCreditoTaxa, Exception> call() =>
      _repository.getTaxaCartaoCredito();
}
