// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

enum TipoValorBase {
  cobrar,
  receber;

  bool get isCobrar => this == TipoValorBase.cobrar;
}

class ValorCalculo extends Equatable {
  final double valor;
  final TipoValorBase tipoValorBase;
  const ValorCalculo({
    required this.valor,
    required this.tipoValorBase,
  });

  @override
  List<Object> get props => [valor, tipoValorBase];
}
