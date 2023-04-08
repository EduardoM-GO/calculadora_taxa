// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'configuracao_store.dart';

abstract class ConfiguracaoState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ConfiguracaoInitState extends ConfiguracaoState {}

class ConfiguracaoLoadingState extends ConfiguracaoState {}

class ConfiguracaoFailureState extends ConfiguracaoState {
  final String erro;

  ConfiguracaoFailureState(this.erro);
  @override
  List<Object?> get props => [erro];
}

class ConfiguracaoSuccessState extends ConfiguracaoState {}

class ConfiguracaoGetTaxaState extends ConfiguracaoState {
  final Taxa pix;
  final Taxa cartaoDebito;
  final CartaoCreditoTaxa cartaoCredito;
  ConfiguracaoGetTaxaState({
    required this.pix,
    required this.cartaoDebito,
    required this.cartaoCredito,
  });

  @override
  List<Object?> get props => [pix, cartaoDebito, cartaoCredito];
}
