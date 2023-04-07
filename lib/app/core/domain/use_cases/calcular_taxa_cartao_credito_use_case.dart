import 'package:calculadora_taxa/app/core/domain/entities/cartao_credito_taxa.dart';
import 'package:calculadora_taxa/app/core/domain/entities/resultado_taxa_cartao_credito.dart';
import 'package:calculadora_taxa/app/core/domain/entities/valor_calculo_cartao_credito.dart';
import 'package:calculadora_taxa/app/core/domain/repositories/taxas_repository.dart';
import 'package:calculadora_taxa/app/core/extensions/double_extension.dart';
import 'package:result_dart/result_dart.dart';

abstract class CalcularTaxaCartaoCreditoUseCase {
  Result<ResultadoTaxaCartaoCredito, Exception> call({
    required ValorCalculoCartaoCredito valorCalculo,
  });
}

class CalcularTaxaCartaoCreditoUseCaseImpl
    implements CalcularTaxaCartaoCreditoUseCase {
  final TaxasRepository _repository;

  CalcularTaxaCartaoCreditoUseCaseImpl(this._repository);
  @override
  Result<ResultadoTaxaCartaoCredito, Exception> call({
    required ValorCalculoCartaoCredito valorCalculo,
  }) {
    final result = _repository.getTaxaCartaoCredito();

    if (result.isError()) {
      return result.fold((success) => Failure(Exception()), Failure.new);
    }

    final cartaoCreditoTaxa = result.fold(
      (success) => success,
      (failure) => const CartaoCreditoTaxa.empty(),
    );
    final percentualTaxa = (valorCalculo.usarTaxaParcelada
            ? cartaoCreditoTaxa.percentualTaxaParcelado
            : cartaoCreditoTaxa.percentualTaxa) /
        100;

    final percentualTaxaPorParcela =
        cartaoCreditoTaxa.percentualTaxaPorParcela / 100;

    late final double valorRecebido;
    late final double valorCobrado;
    if (valorCalculo.tipoValorBase.isCobrar) {
      final valorTaxa = (valorCalculo.valor * percentualTaxa).casasDecimas(2);
      valorRecebido = valorCalculo.valor - valorTaxa;
      valorCobrado = valorCalculo.valor;
    } else {
      valorRecebido = valorCalculo.valor;
      valorCobrado =
          (valorCalculo.valor / (1 - percentualTaxa)).casasDecimas(2);
    }
    late final double valorAcrecimoPorParcela;

    if (valorCalculo.usarTaxaParcelada) {
      final valorBaseParcela = valorCobrado / valorCalculo.quantidadeParcela;
      valorAcrecimoPorParcela =
          (valorBaseParcela * percentualTaxaPorParcela).casasDecimas(2);
    } else {
      valorAcrecimoPorParcela = 0;
    }

    return Success(
      ResultadoTaxaCartaoCredito(
        valorRecebido: valorRecebido,
        valorCobrado: valorCobrado,
        quantidadeParcela: valorCalculo.quantidadeParcela,
        valorAcrescimoParcelaTotal:
            valorAcrecimoPorParcela * valorCalculo.quantidadeParcela,
      ),
    );
  }
}
