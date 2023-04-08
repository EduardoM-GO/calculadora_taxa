// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:calculadora_taxa/app/core/domain/entities/cartao_credito_taxa.dart';
import 'package:calculadora_taxa/app/core/domain/entities/taxa.dart';
import 'package:equatable/equatable.dart';

class Taxas extends Equatable {
  final Taxa pix;
  final Taxa cartaoDebito;
  final CartaoCreditoTaxa cartaoCredito;
  const Taxas({
    required this.pix,
    required this.cartaoDebito,
    required this.cartaoCredito,
  });

  @override
  List<Object> get props => [pix, cartaoDebito, cartaoCredito];
}
