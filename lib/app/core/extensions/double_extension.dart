extension DoubleExtension on double {
  double casasDecimas(int casa) {
    final valor = this;
    final valorString = valor.toStringAsFixed(casa);
    return double.tryParse(valorString) ?? 0;
  }

  String get formatoPercentual {
    final value = this;
    return '${value.casasDecimas(2)}%';
  }
}
