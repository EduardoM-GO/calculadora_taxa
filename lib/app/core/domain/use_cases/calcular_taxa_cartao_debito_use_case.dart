import 'package:calculadora_taxa/app/core/domain/entities/resultado_taxa.dart';
import 'package:calculadora_taxa/app/core/domain/entities/valor_calculo.dart';
import 'package:calculadora_taxa/app/core/domain/repositories/taxas_repository.dart';
import 'package:calculadora_taxa/app/core/extensions/double_extension.dart';
import 'package:result_dart/result_dart.dart';

abstract class CalcularTaxaCartaoDebitoUseCase {
  Result<ResultadoTaxa, Exception> call({
    required ValorCalculo valorCalculo,
  });
}

class CalcularTaxaCartaoDebitoUseCaseImpl
    implements CalcularTaxaCartaoDebitoUseCase {
  final TaxasRepository _repository;

  CalcularTaxaCartaoDebitoUseCaseImpl(this._repository);
  @override
  Result<ResultadoTaxa, Exception> call({
    required ValorCalculo valorCalculo,
  }) {
    final result = _repository.getTaxaCartaoDebito();

    if (result.isError()) {
      return result.fold((success) => Failure(Exception()), Failure.new);
    }
    final percentualTaxa =
        result.fold((success) => success.percentualTaxa / 100, (failure) => 0);

    if (valorCalculo.tipoValorBase.isCobrar) {
      final valorTaxa = (valorCalculo.valor * percentualTaxa).casasDecimas(2);
      return Success(
        ResultadoTaxa(
          valorRecebido: valorCalculo.valor - valorTaxa,
          valorCobrado: valorCalculo.valor,
        ),
      );
    } else {
      final valorCobrar =
          (valorCalculo.valor / (1 - percentualTaxa)).casasDecimas(2);
      return Success(
        ResultadoTaxa(
          valorRecebido: valorCalculo.valor,
          valorCobrado: valorCobrar,
        ),
      );
    }
  }
}
