import 'package:calculadora_taxa/app/core/extensions/double_extension.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('double extension', () async {
    expect(100.0.casasDecimas(4), 100.0000);
    expect(100.0.casasDecimas(0), 100);
    expect(100.1234.casasDecimas(2), 100.12);
  });
}
