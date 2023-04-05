import 'package:calculadora_taxa/app/core/domain/entities/cartao_credito_taxa.dart';
import 'package:calculadora_taxa/app/core/domain/entities/taxa.dart';
import 'package:calculadora_taxa/app/core/domain/repositories/taxas_repository.dart';
import 'package:calculadora_taxa/app/core/infra/cache/taxas_cache.dart';
import 'package:result_dart/result_dart.dart';


class TaxasRepositoryImpl implements TaxasRepository {
  final TaxasCache _cache;

  TaxasRepositoryImpl(this._cache);

  @override
  Result<CartaoCreditoTaxa, Exception> getTaxaCartaoCredito() =>
      _cache.getTaxaCartaoCredito();

  @override
  Result<Taxa, Exception> getTaxaCartaoDebito() => _cache.getTaxaCartaoDebito();

  @override
  Result<Taxa, Exception> getTaxaPix() => _cache.getTaxaPix();

  @override
  Future<Result<Unit, Exception>> setTaxaCartaoCredito({
    required CartaoCreditoTaxa taxa,
  }) =>
      _cache.setTaxaCartaoCredito(taxa: taxa);

  @override
  Future<Result<Unit, Exception>> setTaxaCartaoDebito({required Taxa taxa}) =>
      _cache.setTaxaCartaoDebito(taxa: taxa);

  @override
  Future<Result<Unit, Exception>> setTaxaPix({required Taxa taxa}) =>
      _cache.setTaxaPix(taxa: taxa);
}
