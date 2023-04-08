import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class RealMask extends TextInputFormatter {
  final NumberFormat _formatter =
      NumberFormat.currency(locale: 'pt_BR', symbol: r'R$', decimalDigits: 2);

  double removerMask(String value) => _formatter.parse(value).toDouble();
  String addMask(double value) => _formatter.format(value);

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.isEmpty) {
      return newValue.copyWith(text: '');
    }
    if (newValue.text == '0') {
      return newValue.copyWith(text: r'R$ 0,00');
    }

    final semPonto =

        ///remove os zeros da frente
        (int.tryParse(newValue.text.replaceAll(RegExp('[.,]'), '')) ?? 0)
            .toString();

    late final String comSeparador;
    if (semPonto.length > 2) {
      comSeparador = '${semPonto.substring(0, semPonto.length - 2)}.'
          '${semPonto.substring(semPonto.length - 2)}';
    } else {
      comSeparador = '0.${semPonto.padLeft(2, '0')}';
    }

    final newText = StringBuffer();
    final value = double.tryParse(comSeparador) ?? 0.0;
    newText.write(_formatter.format(value));
    return TextEditingValue(
      text: newText.toString(),
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}
