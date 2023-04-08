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
