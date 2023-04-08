// ignore_for_file: lines_longer_than_80_chars

import 'package:flutter/services.dart';

class DoubleMask extends TextInputFormatter {
  final _separadorMilhares = ' ';

  FilteringTextInputFormatter caracterPermitido() =>
      FilteringTextInputFormatter.allow(RegExp(r'[\d,]'));

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (RegExp(',').allMatches(newValue.text).length > 1) {
      return oldValue;
    }
    return _addPonto(newValue);
  }

  String removerSeparador(String value) =>
      value.replaceAll(_separadorMilhares, '');

  String addSeparadorMilhares(String value) =>
      _addPonto(TextEditingValue(text: value.replaceAll(RegExp(r'[^\d,]'), '')))
          .text;

  double stringToDouble(String value) {
    final valorRegex =
        RegExp(r'(\d*)(\,?)(\d*)').firstMatch(removerSeparador(value));
    final decimal = StringBuffer(valorRegex?.group(3) ?? '');

    //verifica se tem no minimo 4 casa depois da virgula
    for (var i = (valorRegex?.group(3) ?? '').length; i < 4; i++) {
      decimal.write('0');
    }
    if (decimal.isEmpty) {
      decimal.write(valorRegex?.group(3) ?? '');
    }
    return double.parse('${valorRegex?.group(1) ?? '0'}.$decimal');
  }

  ///Decimal to String
  ///
  ///separadorMilhares  default  true
  ///
  ///se separadorMilhares for true vai retorna 1 000,0000 || 1 000 000,0000
  ///
  ///se for false vai retorna 1000,0000 || 1000000,0000
  String doubleToString(
    double value, {
    bool separaMilhares = true,
    int? quantidadeCasaDecimal,
  }) {
    final valorRegex = RegExp(r'(\d*)(\.?)(\d*)').firstMatch(value.toString());
    final decimal = StringBuffer(valorRegex?.group(3) ?? '');
    for (var i = (valorRegex?.group(3) ?? '').length;
        i < (quantidadeCasaDecimal ?? 4);
        i++) {
      decimal.write('0');
    }
    if (decimal.isEmpty) {
      decimal.write(valorRegex?.group(3));
    }
    return '${separaMilhares ? addSeparadorMilhares(valorRegex?.group(1) ?? '') : valorRegex?.group(1) ?? ''}'
        '${(quantidadeCasaDecimal ?? 4) > 0 ? ',' : ''}'
        '${quantidadeCasaDecimal != null ? decimal.toString().substring(0, quantidadeCasaDecimal) : decimal.toString()}';
  }

  ///Aplica o separador de milhares no valor passado
  TextEditingValue _addPonto(TextEditingValue textEdit) {
    //group 2 são onde deve adicionar o separador de milhares
    //group 4 são as casa depois da virgula
    var selectionIndex = textEdit.selection.baseOffset;

    final valorSemMascara =
        RegExp(r'\b(\d{1,3})((\d{3})*)\b(,?\d*)?').firstMatch(textEdit.text);

    final valorRetorno = StringBuffer()..write(valorSemMascara?.group(1) ?? '');

    final valorDeveAddMascara =
        RegExp(r'(\d{3})').allMatches(valorSemMascara?.group(2) ?? '').toList();
    for (var i = 0;
        i < valorDeveAddMascara.length;
        i++
        //final element in valorDeveAddMascara
        ) {
      valorRetorno
          .write('$_separadorMilhares${valorDeveAddMascara[i].group(1)}');
      if (textEdit.selection.baseOffset > (i + 1) * 3) {
        selectionIndex++;
      }
    }
    valorRetorno.write(valorSemMascara?.group(4) ?? '');

    return TextEditingValue(
      text: valorRetorno.toString(),
      selection: TextSelection.collapsed(offset: selectionIndex),
    );
  }
}
