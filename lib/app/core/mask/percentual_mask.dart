import 'package:flutter/services.dart';

class PercentualMask extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.isEmpty) {
      return newValue.copyWith(text: '');
    } else if (newValue.text == '0') {
      return newValue.copyWith(text: '0.00%');
    } else if (newValue.text.endsWith('%')) {
      return newValue;
    } else {
      final value = double.tryParse(newValue.text.replaceAll(',', '.')) ?? 0.0;
      final newText = '${(value / 100).toStringAsFixed(2)}%';
      return newValue.copyWith(
        text: newText,
        selection: TextSelection.collapsed(offset: newText.length - 1),
      );
    }
  }
}
