import 'package:calculadora_taxa/app/core/domain/entities/resultado_taxa.dart';
import 'package:calculadora_taxa/app/core/domain/entities/valor_calculo.dart';
import 'package:calculadora_taxa/app/core/domain/repositories/taxas_repository.dart';
import 'package:calculadora_taxa/app/core/extensions/double_extension.dart';
import 'package:result_dart/result_dart.dart';

abstract class CalcularTaxaPixUseCase {
  Result<ResultadoTaxa, Exception> call({
    required ValorCalculo valorCalculo,
  });
}

class CalcularTaxaPixUseCaseImpl implements CalcularTaxaPixUseCase {
  final TaxasRepository _repository;

  CalcularTaxaPixUseCaseImpl(this._repository);
  @override
  Result<ResultadoTaxa, Exception> call({
    required ValorCalculo valorCalculo,
  }) {
    final result = _repository.getTaxaPix();

    if (result.isError()) {
      return Failure(result.exceptionOrNull()!);
    }
    final percentualTaxa = result.getOrThrow().percentualTaxa / 100;

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
