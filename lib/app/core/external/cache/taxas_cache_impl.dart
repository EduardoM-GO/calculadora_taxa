import 'package:calculadora_taxa/app/core/domain/entities/cartao_credito_taxa.dart';
import 'package:calculadora_taxa/app/core/domain/entities/taxa.dart';
import 'package:calculadora_taxa/app/core/infra/cache/taxas_cache.dart';
import 'package:flutter/material.dart';
import 'package:result_dart/result_dart.dart';
import 'package:shared_preferences/shared_preferences.dart';

@visibleForTesting
enum ChavesPreferences {
  pix,
  cartaoDebito,
  cartaoCredito,
  cartaoCreditoParcelado
}

class TaxasCacheImpl implements TaxasCache {
  final SharedPreferences _sharedPreferences;

  const TaxasCacheImpl(this._sharedPreferences);
  @override
  Result<CartaoCreditoTaxa, Exception> getTaxaCartaoCredito() {
    try {
      final percentualTaxa =
          _sharedPreferences.getDouble(ChavesPreferences.cartaoCredito.name) ??
              0;

      final percentualTaxaParcelado = _sharedPreferences.getDouble(
            ChavesPreferences.cartaoCreditoParcelado.name,
          ) ??
          0;

      return Success(
        CartaoCreditoTaxa(
          percentualTaxa: percentualTaxa,
          percentualTaxaParcelado: percentualTaxaParcelado,
        ),
      );
    } catch (exception) {
      return Failure(Exception(exception));
    }
  }

  @override
  Result<Taxa, Exception> getTaxaCartaoDebito() {
    try {
      final percentualTaxa =
          _sharedPreferences.getDouble(ChavesPreferences.cartaoDebito.name) ??
              0;
      return Success(Taxa(percentualTaxa: percentualTaxa));
    } catch (exception) {
      return Failure(Exception(exception));
    }
  }

  @override
  Result<Taxa, Exception> getTaxaPix() {
    try {
      final percentualTaxa =
          _sharedPreferences.getDouble(ChavesPreferences.pix.name) ?? 0;
      return Success(Taxa(percentualTaxa: percentualTaxa));
    } catch (exception) {
      return Failure(Exception(exception));
    }
  }

  @override
  Future<Result<Unit, Exception>> setTaxaCartaoCredito({
    required CartaoCreditoTaxa taxa,
  }) async {
    try {
      await _sharedPreferences.setDouble(
        ChavesPreferences.cartaoCredito.name,
        taxa.percentualTaxa,
      );

      await _sharedPreferences.setDouble(
        ChavesPreferences.cartaoCreditoParcelado.name,
        taxa.percentualTaxaParcelado,
      );

      return const Success(unit);
    } catch (exception) {
      return Failure(Exception(exception));
    }
  }

  @override
  Future<Result<Unit, Exception>> setTaxaCartaoDebito({
    required Taxa taxa,
  }) async {
    try {
      await _sharedPreferences.setDouble(
        ChavesPreferences.cartaoDebito.name,
        taxa.percentualTaxa,
      );
      return const Success(unit);
    } catch (exception) {
      return Failure(Exception(exception));
    }
  }

  @override
  Future<Result<Unit, Exception>> setTaxaPix({required Taxa taxa}) async {
    try {
      await _sharedPreferences.setDouble(
        ChavesPreferences.pix.name,
        taxa.percentualTaxa,
      );
      return const Success(unit);
    } catch (exception) {
      return Failure(Exception(exception));
    }
  }
}
