import 'package:calculadora_taxa/app/core/domain/entities/taxas.dart';
import 'package:calculadora_taxa/app/core/domain/repositories/taxas_repository.dart';
import 'package:result_dart/result_dart.dart';

abstract class GetTaxasUseCase {
  Result<Taxas, Exception> call();
}

class GetTaxasUseCaseImpl implements GetTaxasUseCase {
  final TaxasRepository _repository;

  GetTaxasUseCaseImpl(this._repository);
  @override
  Result<Taxas, Exception> call() {
    final resultCartaoCredito = _repository.getTaxaCartaoCredito();
    if (resultCartaoCredito.isError()) {
      return Failure(resultCartaoCredito.exceptionOrNull()!);
    }
    final cartaoCredito = resultCartaoCredito.getOrThrow();

    final resultCartaoDebito = _repository.getTaxaCartaoDebito();
    if (resultCartaoDebito.isError()) {
      return Failure(resultCartaoDebito.exceptionOrNull()!);
    }
    final cartaoDebito = resultCartaoDebito.getOrThrow();

    final resultPix = _repository.getTaxaPix();

    if (resultPix.isError()) {
      return Failure(resultPix.exceptionOrNull()!);
    }

    final pix = resultPix.getOrThrow();
    return Success(
      Taxas(
        pix: pix,
        cartaoDebito: cartaoDebito,
        cartaoCredito: cartaoCredito,
      ),
    );
  }
}
