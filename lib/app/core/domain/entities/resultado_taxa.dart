// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class ResultadoTaxa extends Equatable {
  final double valorRecebido;
  final double valorCobrado;
  const ResultadoTaxa({
    required this.valorRecebido,
    required this.valorCobrado,
  });

  double get valorTaxa => valorCobrado - valorRecebido;

  @override
  List<Object> get props => [valorRecebido, valorCobrado];
}
