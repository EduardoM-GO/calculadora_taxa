import 'package:calculadora_taxa/app/core/domain/repositories/taxas_repository.dart';
import 'package:calculadora_taxa/app/core/domain/use_cases/calcular_taxa_cartao_credito_use_case.dart';
import 'package:calculadora_taxa/app/core/domain/use_cases/calcular_taxa_cartao_debito_use_case.dart';
import 'package:calculadora_taxa/app/core/domain/use_cases/calcular_taxa_pix_use_case.dart';
import 'package:calculadora_taxa/app/core/domain/use_cases/set_taxas_use_case.dart';
import 'package:calculadora_taxa/app/core/external/cache/taxas_cache_impl.dart';
import 'package:calculadora_taxa/app/core/infra/cache/taxas_cache.dart';
import 'package:calculadora_taxa/app/core/infra/repositories/taxas_repository_impl.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InjecaoDependencia {
  InjecaoDependencia._();

  static Future<void> init() async {
    GetIt.I.registerSingletonAsync<SharedPreferences>(
      SharedPreferences.getInstance,
    );
    await GetIt.I.isReady<SharedPreferences>();

    GetIt.I.registerFactory<TaxasCache>(() => TaxasCacheImpl(GetIt.I()));
    GetIt.I
        .registerFactory<TaxasRepository>(() => TaxasRepositoryImpl(GetIt.I()));
    GetIt.I
        .registerFactory<SetTaxasUseCase>(() => SetTaxasUseCaseImpl(GetIt.I()));
    GetIt.I.registerFactory<CalcularTaxaPixUseCase>(
      () => CalcularTaxaPixUseCaseImpl(GetIt.I()),
    );
    GetIt.I.registerFactory<CalcularTaxaCartaoDebitoUseCase>(
      () => CalcularTaxaCartaoDebitoUseCaseImpl(GetIt.I()),
    );
    GetIt.I.registerFactory<CalcularTaxaCartaoCreditoUseCase>(
      () => CalcularTaxaCartaoCreditoUseCaseImpl(GetIt.I()),
    );
  }
}
