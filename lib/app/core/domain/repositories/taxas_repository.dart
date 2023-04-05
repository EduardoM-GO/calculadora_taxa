import 'package:calculadora_taxa/app/core/domain/entities/cartao_credito_taxa.dart';
import 'package:calculadora_taxa/app/core/domain/entities/taxa.dart';
import 'package:result_dart/result_dart.dart';

abstract class TaxasRepository {
  Future<Result<Unit, Exception>> setTaxaPix({required Taxa taxa});
  Future<Result<Unit, Exception>> setTaxaCartaoDebito({required Taxa taxa});
  Future<Result<Unit, Exception>> setTaxaCartaoCredito({
    required CartaoCreditoTaxa taxa,
  });
  Result<Taxa, Exception> getTaxaPix();
  Result<Taxa, Exception> getTaxaCartaoDebito();
  Result<CartaoCreditoTaxa, Exception> getTaxaCartaoCredito();
}
