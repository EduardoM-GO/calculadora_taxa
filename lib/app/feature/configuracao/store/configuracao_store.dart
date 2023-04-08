import 'package:calculadora_taxa/app/core/domain/entities/cartao_credito_taxa.dart';
import 'package:calculadora_taxa/app/core/domain/entities/taxa.dart';
import 'package:calculadora_taxa/app/core/domain/use_cases/get_taxas_use_case.dart';
import 'package:calculadora_taxa/app/core/domain/use_cases/set_taxas_use_case.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'configuracao_state.dart';

class ConfiguracaoStore extends ValueNotifier<ConfiguracaoState> {
  final SetTaxasUseCase _useCase;
  final GetTaxasUseCase _getTaxasUseCase;
  ConfiguracaoStore(this._useCase, this._getTaxasUseCase)
      : super(ConfiguracaoInitState());

  void get() {
    final result = _getTaxasUseCase();

    value = result.fold(
      (success) => ConfiguracaoGetTaxaState(
        pix: success.pix,
        cartaoDebito: success.cartaoDebito,
        cartaoCredito: success.cartaoCredito,
      ),
      (failure) => ConfiguracaoFailureState(failure.toString()),
    );
  }

  Future<void> salvar({
    required double cartaoCreditoTaxa,
    required double cartaoCreditoTaxaParcelado,
    required double cartaoDebitoTaxa,
    required double pixTaxa,
  }) async {
    value = ConfiguracaoLoadingState();
    final result = await _useCase(
      cartaoCredito: CartaoCreditoTaxa(
        percentualTaxa: cartaoCreditoTaxa,
        percentualTaxaParcelado: cartaoCreditoTaxaParcelado,
      ),
      cartaoDebito: Taxa(percentualTaxa: cartaoCreditoTaxa),
      pix: Taxa(percentualTaxa: pixTaxa),
    );

    value = result.fold(
      (success) => ConfiguracaoSuccessState(),
      (failure) => ConfiguracaoFailureState(failure.toString()),
    );
  }
}
