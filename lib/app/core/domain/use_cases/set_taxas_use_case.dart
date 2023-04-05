import 'package:calculadora_taxa/app/core/domain/entities/cartao_credito_taxa.dart';
import 'package:calculadora_taxa/app/core/domain/entities/taxa.dart';
import 'package:calculadora_taxa/app/core/domain/repositories/taxas_repository.dart';
import 'package:result_dart/result_dart.dart';

abstract class SetTaxasUseCase {
  Future<Result<Unit, Exception>> call({
    required CartaoCreditoTaxa cartaoCredito,
    required Taxa cartaoDebito,
    required Taxa pix,
  });
}

class SetTaxasUseCaseImpl implements SetTaxasUseCase {
  final TaxasRepository _repository;

  SetTaxasUseCaseImpl(this._repository);
  @override
  Future<Result<Unit, Exception>> call({
    required CartaoCreditoTaxa cartaoCredito,
    required Taxa cartaoDebito,
    required Taxa pix,
  }) async {
    final resultCartaoCredito =
        await _repository.setTaxaCartaoCredito(taxa: cartaoCredito);
    if (resultCartaoCredito.isError()) {
      return resultCartaoCredito;
    }

    final resultCartaoDebito =
        await _repository.setTaxaCartaoDebito(taxa: cartaoDebito);
    if (resultCartaoDebito.isError()) {
      return resultCartaoDebito;
    }

    final resultPix = await _repository.setTaxaPix(taxa: pix);

    return resultPix;
  }
}
