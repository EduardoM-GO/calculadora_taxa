import 'package:calculadora_taxa/app/core/domain/entities/valor_calculo.dart';
import 'package:calculadora_taxa/app/core/domain/entities/valor_calculo_cartao_credito.dart';
import 'package:calculadora_taxa/app/core/domain/use_cases/calcular_taxa_cartao_credito_use_case.dart';
import 'package:flutter/material.dart';

enum QuantidadeParcelas {
  x1(1),
  x2(2),
  x3(3),
  x4(4),
  x5(5),
  x6(6),
  x7(7),
  x8(8),
  x9(9),
  x10(10),
  x11(11),
  x12(12),
  x13(13),
  x14(14),
  x15(15),
  x16(16),
  x17(17),
  x18(18);

  final int numeroParcela;
  String get nome => '${numeroParcela}x';
  const QuantidadeParcelas(this.numeroParcela);
}

class CartaoCreditoStore extends ChangeNotifier {
  final CalcularTaxaCartaoCreditoUseCase _useCase;

  CartaoCreditoStore(this._useCase);

  double _valorReceber = 0;
  double _valorCobrar = 0;
  double _percentualTaxa = 0;
  double _valorTaxa = 0;
  double _valorDaParcela = 0;
  double _valorAcrescimoPorParcela = 0;
  double _valorAcrescimoParcelaTotal = 0;
  double _percentualTaxaParcela = 0;

  ///Armazena o ultimo TipoValorBase
  TipoValorBase _tipoValorBase = TipoValorBase.cobrar;

  QuantidadeParcelas _quantidadeParcela = QuantidadeParcelas.x1;

  QuantidadeParcelas get quantidadeParcela => _quantidadeParcela;
  
  set quantidadeParcela(QuantidadeParcelas quantidadeParcelas) {
    if (_quantidadeParcela != quantidadeParcelas) {
      _quantidadeParcela = quantidadeParcelas;
      _atualizaValores();
    }
  }

  double get valorReceber => _valorReceber;

  double get valorCobrar => _valorCobrar;

  double get percentualTaxa => _percentualTaxa;

  double get valorTaxa => _valorTaxa;

  double get valorDaParcela => _valorDaParcela;

  double get valorAcrescimoPorParcela => _valorAcrescimoPorParcela;

  double get valorAcrescimoParcelaTotal => _valorAcrescimoParcelaTotal;

  double get percentualTaxaParcela => _percentualTaxaParcela;

  void calculaValorCobrar({required double valorReceber}) {
    _tipoValorBase = TipoValorBase.receber;
    _useCase(
      valorCalculo: ValorCalculoCartaoCredito(
        valor: valorReceber,
        tipoValorBase: _tipoValorBase,
        quantidadeParcela: _quantidadeParcela.numeroParcela,
      ),
    ).fold(
      (success) {
        _valorReceber = success.valorRecebido;
        _valorCobrar = success.valorCobrado;
        _percentualTaxa = success.percentualTaxa;
        _valorTaxa = success.valorTaxa;
        _valorDaParcela = success.valorDaParcela;
        _valorAcrescimoPorParcela = success.valorAcrescimoPorParcela;
        _valorAcrescimoParcelaTotal = success.valorAcrescimoParcelaTotal;
        _percentualTaxaParcela = success.percentualTaxaParcela;
        notifyListeners();
      },
      (failure) => null,
    );
  }

  void _atualizaValores() {
    _useCase(
      valorCalculo: ValorCalculoCartaoCredito(
        valor: _tipoValorBase.isCobrar ? valorCobrar : valorReceber,
        tipoValorBase: _tipoValorBase,
        quantidadeParcela: _quantidadeParcela.numeroParcela,
      ),
    ).fold(
      (success) {
        _valorReceber = success.valorRecebido;
        _valorCobrar = success.valorCobrado;
        _percentualTaxa = success.percentualTaxa;
        _valorTaxa = success.valorTaxa;
        _valorDaParcela = success.valorDaParcela;
        _valorAcrescimoPorParcela = success.valorAcrescimoPorParcela;
        _valorAcrescimoParcelaTotal = success.valorAcrescimoParcelaTotal;
        _percentualTaxaParcela = success.percentualTaxaParcela;
        notifyListeners();
      },
      (failure) => null,
    );
  }

  void calculaValorReceber({required double valorCobrar}) {
    _tipoValorBase = TipoValorBase.cobrar;
    _useCase(
      valorCalculo: ValorCalculoCartaoCredito(
        valor: valorCobrar,
        tipoValorBase: _tipoValorBase,
        quantidadeParcela: _quantidadeParcela.numeroParcela,
      ),
    ).fold(
      (success) {
        _valorReceber = success.valorRecebido;
        _valorCobrar = success.valorCobrado;
        _percentualTaxa = success.percentualTaxa;
        _valorTaxa = success.valorTaxa;
        _valorDaParcela = success.valorDaParcela;
        _valorAcrescimoPorParcela = success.valorAcrescimoPorParcela;
        _valorAcrescimoParcelaTotal = success.valorAcrescimoParcelaTotal;
        _percentualTaxaParcela = success.percentualTaxaParcela;
        notifyListeners();
      },
      (failure) => null,
    );
  }
}
