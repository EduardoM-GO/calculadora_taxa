import 'package:equatable/equatable.dart';

class Taxa extends Equatable {
  final double percentualTaxa;
  const Taxa({
    required this.percentualTaxa,
  });

  @override
  List<Object> get props => [percentualTaxa];
}
