import 'package:calculadora_taxa/app/core/domain/entities/valor_calculo.dart';
import 'package:calculadora_taxa/app/core/domain/use_cases/calcular_taxa_pix_use_case.dart';
import 'package:flutter/material.dart';

class PixStore extends ChangeNotifier {
  final CalcularTaxaPixUseCase _useCase;

  PixStore(this._useCase);

  double _valorReceber = 0;
  double _valorCobrar = 0;
  double _percentualTaxa = 0;
  double _valorTaxa = 0;

  double get valorReceber => _valorReceber;

  double get valorCobrar => _valorCobrar;

  double get percentualTaxa => _percentualTaxa;
  double get valorTaxa => _valorTaxa;

  void calculaValorCobrar({required double valorReceber}) {
    _useCase(
      valorCalculo: ValorCalculo(
        valor: valorReceber,
        tipoValorBase: TipoValorBase.receber,
      ),
    ).fold(
      (success) {
        _valorReceber = success.valorRecebido;
        _valorCobrar = success.valorCobrado;
        _percentualTaxa = success.percentualTaxa;
        _valorTaxa = success.valorTaxa;

        notifyListeners();
      },
      (failure) => null,
    );
  }

  void calculaValorReceber({required double valorCobrar}) {
    _useCase(
      valorCalculo: ValorCalculo(
        valor: valorCobrar,
        tipoValorBase: TipoValorBase.cobrar,
      ),
    ).fold(
      (success) {
        _valorReceber = success.valorRecebido;
        _valorCobrar = success.valorCobrado;
        _percentualTaxa = success.percentualTaxa;
        _valorTaxa = success.valorTaxa;
        notifyListeners();
      },
      (failure) => null,
    );
  }
}
