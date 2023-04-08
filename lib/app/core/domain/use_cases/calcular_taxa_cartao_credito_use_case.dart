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
      return Failure(result.exceptionOrNull()!);
    }

    final cartaoCreditoTaxa = result.getOrThrow();

    final percentualTaxa = (valorCalculo.usarTaxaParcelada
            ? cartaoCreditoTaxa.percentualTaxaParcelado
            : cartaoCreditoTaxa.percentualTaxa) /
        100;

    late final double valorRecebido;
    late final double valorCobrado;

    /// Verifica se o valor base é cobraça ou recebimento
    if (valorCalculo.tipoValorBase.isCobrar) {
      ///Obtem o valor que vai ser descontado no recebimento
      final valorTaxa = (valorCalculo.valor * percentualTaxa).casasDecimas(2);
      valorRecebido = valorCalculo.valor - valorTaxa;
      valorCobrado = valorCalculo.valor;
    } else {
      valorRecebido = valorCalculo.valor;
      valorCobrado =
          (valorCalculo.valor / (1 - percentualTaxa)).casasDecimas(2);
    }

    /// Obtem o valor que vai ser aumentado na parcela para o cliente
    late final double valorAcrescimoParcelaTotal;
    if (valorCalculo.usarTaxaParcelada) {
      valorAcrescimoParcelaTotal = valorCobrado * valorCalculo.taxaParcela;
    } else {
      valorAcrescimoParcelaTotal = 0;
    }

    return Success(
      ResultadoTaxaCartaoCredito(
        valorRecebido: valorRecebido,
        valorCobrado: valorCobrado,
        quantidadeParcela: valorCalculo.quantidadeParcela,
        valorAcrescimoParcelaTotal: valorAcrescimoParcelaTotal.casasDecimas(2),
      ),
    );
  }
}
