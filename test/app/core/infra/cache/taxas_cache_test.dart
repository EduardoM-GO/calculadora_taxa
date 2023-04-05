import 'package:calculadora_taxa/app/core/domain/entities/cartao_credito_taxa.dart';
import 'package:calculadora_taxa/app/core/domain/entities/taxa.dart';
import 'package:calculadora_taxa/app/core/external/cache/taxas_cache_impl.dart';
import 'package:calculadora_taxa/app/core/infra/cache/taxas_cache.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:result_dart/functions.dart';
import 'package:result_dart/result_dart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class _SharedPreferencesMock extends Mock implements SharedPreferences {}

void main() {
  late SharedPreferences sharedPreferences;
  late CartaoCreditoTaxa cartaoCreditoTaxa;
  late Taxa cartaoTaxa;
  late Taxa pixTaxa;
  late TaxasCache cache;

  setUp(() {
    sharedPreferences = _SharedPreferencesMock();
    cartaoCreditoTaxa = const CartaoCreditoTaxa(
      percentualTaxa: 1,
      percentualTaxaParcelado: 2.8,
      percentualTaxaPorParcela: 3.6,
    );
    cartaoTaxa = const Taxa(percentualTaxa: 2);
    pixTaxa = const Taxa(percentualTaxa: 3.33);
    cache = TaxasCacheImpl(sharedPreferences);
  });

  group('Cartão Credito -', () {
    group('set -', () {
      test('Ok', () async {
        when(
          () => sharedPreferences.setDouble(
            ChavesPreferences.cartaoCredito.name,
            cartaoCreditoTaxa.percentualTaxa,
          ),
        ).thenAnswer((_) async => true);
        when(
          () => sharedPreferences.setDouble(
            ChavesPreferences.cartaoCreditoParcelado.name,
            cartaoCreditoTaxa.percentualTaxaParcelado,
          ),
        ).thenAnswer((_) async => true);
        when(
          () => sharedPreferences.setDouble(
            ChavesPreferences.cartaoCreditoPorParcela.name,
            cartaoCreditoTaxa.percentualTaxaPorParcela,
          ),
        ).thenAnswer((_) async => true);

        final result =
            await cache.setTaxaCartaoCredito(taxa: cartaoCreditoTaxa);
        expect(result.isSuccess(), true);
        expect(
          result.fold(id, id),
          isA<Unit>(),
        );
      });

      group('Erro -', () {
        test('cartaoCredito', () async {
          when(
            () => sharedPreferences.setDouble(
              ChavesPreferences.cartaoCredito.name,
              cartaoCreditoTaxa.percentualTaxa,
            ),
          ).thenThrow(Exception());
          when(
            () => sharedPreferences.setDouble(
              ChavesPreferences.cartaoCreditoParcelado.name,
              cartaoCreditoTaxa.percentualTaxaParcelado,
            ),
          ).thenAnswer((_) async => true);
          when(
            () => sharedPreferences.setDouble(
              ChavesPreferences.cartaoCreditoPorParcela.name,
              cartaoCreditoTaxa.percentualTaxaPorParcela,
            ),
          ).thenAnswer((_) async => true);

          final result =
              await cache.setTaxaCartaoCredito(taxa: cartaoCreditoTaxa);
          expect(result.isError(), true);
          expect(
            result.fold(id, id),
            isA<Exception>(),
          );
        });
        test('cartaoCreditoParcelado', () async {
          when(
            () => sharedPreferences.setDouble(
              ChavesPreferences.cartaoCredito.name,
              cartaoCreditoTaxa.percentualTaxa,
            ),
          ).thenAnswer((_) async => true);
          when(
            () => sharedPreferences.setDouble(
              ChavesPreferences.cartaoCreditoParcelado.name,
              cartaoCreditoTaxa.percentualTaxaParcelado,
            ),
          ).thenThrow(Exception());
          when(
            () => sharedPreferences.setDouble(
              ChavesPreferences.cartaoCreditoPorParcela.name,
              cartaoCreditoTaxa.percentualTaxaPorParcela,
            ),
          ).thenAnswer((_) async => true);

          final result =
              await cache.setTaxaCartaoCredito(taxa: cartaoCreditoTaxa);
          expect(result.isError(), true);
          expect(
            result.fold(id, id),
            isA<Exception>(),
          );
        });
      });
      test('cartaoCreditoPorParcela', () async {
        when(
          () => sharedPreferences.setDouble(
            ChavesPreferences.cartaoCredito.name,
            cartaoCreditoTaxa.percentualTaxa,
          ),
        ).thenAnswer((_) async => true);
        when(
          () => sharedPreferences.setDouble(
            ChavesPreferences.cartaoCreditoParcelado.name,
            cartaoCreditoTaxa.percentualTaxaParcelado,
          ),
        ).thenAnswer((_) async => true);
        when(
          () => sharedPreferences.setDouble(
            ChavesPreferences.cartaoCreditoPorParcela.name,
            cartaoCreditoTaxa.percentualTaxaPorParcela,
          ),
        ).thenThrow(Exception());

        final result =
            await cache.setTaxaCartaoCredito(taxa: cartaoCreditoTaxa);
        expect(result.isError(), true);
        expect(
          result.fold(id, id),
          isA<Exception>(),
        );
      });
    });

    group('get -', () {
      test('Ok', () {
        when(
          () => sharedPreferences.getDouble(
            ChavesPreferences.cartaoCredito.name,
          ),
        ).thenReturn(cartaoCreditoTaxa.percentualTaxa);
        when(
          () => sharedPreferences.getDouble(
            ChavesPreferences.cartaoCreditoParcelado.name,
          ),
        ).thenReturn(cartaoCreditoTaxa.percentualTaxaParcelado);
        when(
          () => sharedPreferences.getDouble(
            ChavesPreferences.cartaoCreditoPorParcela.name,
          ),
        ).thenReturn(cartaoCreditoTaxa.percentualTaxaPorParcela);

        final result = cache.getTaxaCartaoCredito();
        expect(result.isSuccess(), true);
        expect(
          result.fold(id, id),
          isA<CartaoCreditoTaxa>(),
        );
        expect(
          result.fold(id, id),
          cartaoCreditoTaxa,
        );
      });
      group('Erro -', () {
        test('cartaoCredito', () {
          when(
            () => sharedPreferences.getDouble(
              ChavesPreferences.cartaoCredito.name,
            ),
          ).thenThrow(Exception());
          when(
            () => sharedPreferences.getDouble(
              ChavesPreferences.cartaoCreditoParcelado.name,
            ),
          ).thenReturn(cartaoCreditoTaxa.percentualTaxaParcelado);
          when(
            () => sharedPreferences.getDouble(
              ChavesPreferences.cartaoCreditoPorParcela.name,
            ),
          ).thenReturn(cartaoCreditoTaxa.percentualTaxaPorParcela);

          final result = cache.getTaxaCartaoCredito();
          expect(result.isError(), true);
          expect(
            result.fold(id, id),
            isA<Exception>(),
          );
        });
        test('cartaoCreditoParcelado', () {
          when(
            () => sharedPreferences.getDouble(
              ChavesPreferences.cartaoCredito.name,
            ),
          ).thenReturn(cartaoCreditoTaxa.percentualTaxa);
          when(
            () => sharedPreferences.getDouble(
              ChavesPreferences.cartaoCreditoParcelado.name,
            ),
          ).thenThrow(Exception());
          when(
            () => sharedPreferences.getDouble(
              ChavesPreferences.cartaoCreditoPorParcela.name,
            ),
          ).thenReturn(cartaoCreditoTaxa.percentualTaxaPorParcela);

          final result = cache.getTaxaCartaoCredito();
          expect(result.isError(), true);
          expect(
            result.fold(id, id),
            isA<Exception>(),
          );
        });
        test('cartaoCreditoPorParcela', () {
          when(
            () => sharedPreferences.getDouble(
              ChavesPreferences.cartaoCredito.name,
            ),
          ).thenReturn(cartaoCreditoTaxa.percentualTaxa);
          when(
            () => sharedPreferences.getDouble(
              ChavesPreferences.cartaoCreditoParcelado.name,
            ),
          ).thenReturn(cartaoCreditoTaxa.percentualTaxaParcelado);
          when(
            () => sharedPreferences.getDouble(
              ChavesPreferences.cartaoCreditoPorParcela.name,
            ),
          ).thenThrow(Exception());

          final result = cache.getTaxaCartaoCredito();
          expect(result.isError(), true);
          expect(
            result.fold(id, id),
            isA<Exception>(),
          );
        });
      });
    });
  });
  group('Cartão Debito -', () {
    group('set -', () {
      test('ok', () async {
        when(
          () => sharedPreferences.setDouble(
            ChavesPreferences.cartaoDebito.name,
            cartaoTaxa.percentualTaxa,
          ),
        ).thenAnswer((_) async => true);
        final result = await cache.setTaxaCartaoDebito(taxa: cartaoTaxa);
        expect(result.isSuccess(), true);
        expect(result.fold(id, id), isA<Unit>());
      });
      test('erro', () async {
        when(
          () => sharedPreferences.setDouble(
            ChavesPreferences.cartaoDebito.name,
            cartaoTaxa.percentualTaxa,
          ),
        ).thenThrow(Exception());
        final result = await cache.setTaxaCartaoDebito(taxa: cartaoTaxa);
        expect(result.isError(), true);
        expect(result.fold(id, id), isA<Exception>());
      });
    });

    group('get -', () {
      test('ok', () async {
        when(
          () => sharedPreferences.getDouble(
            ChavesPreferences.cartaoDebito.name,
          ),
        ).thenReturn(cartaoTaxa.percentualTaxa);
        final result = cache.getTaxaCartaoDebito();
        expect(result.isSuccess(), true);
        expect(result.fold(id, id), isA<Taxa>());
        expect(result.fold(id, id), cartaoTaxa);
      });
      test('erro', () async {
        when(
          () => sharedPreferences.getDouble(
            ChavesPreferences.cartaoDebito.name,
          ),
        ).thenThrow(Exception());
        final result = cache.getTaxaCartaoDebito();
        expect(result.isError(), true);
        expect(result.fold(id, id), isA<Exception>());
      });
    });
  });
  group('Pix -', () {
    group('set -', () {
      test('ok', () async {
        when(
          () => sharedPreferences.setDouble(
            ChavesPreferences.pix.name,
            pixTaxa.percentualTaxa,
          ),
        ).thenAnswer((_) async => true);
        final result = await cache.setTaxaPix(taxa: pixTaxa);
        expect(result.isSuccess(), true);
        expect(result.fold(id, id), isA<Unit>());
      });
      test('erro', () async {
        when(
          () => sharedPreferences.setDouble(
            ChavesPreferences.pix.name,
            pixTaxa.percentualTaxa,
          ),
        ).thenThrow(Exception());
        final result = await cache.setTaxaPix(taxa: pixTaxa);
        expect(result.isError(), true);
        expect(result.fold(id, id), isA<Exception>());
      });
    });

    group('get -', () {
      test('ok', () async {
        when(
          () => sharedPreferences.getDouble(
            ChavesPreferences.pix.name,
          ),
        ).thenReturn(pixTaxa.percentualTaxa);
        final result = cache.getTaxaPix();
        expect(result.isSuccess(), true);
        expect(result.fold(id, id), isA<Taxa>());
        expect(result.fold(id, id), pixTaxa);
      });
      test('erro', () async {
        when(
          () => sharedPreferences.getDouble(
            ChavesPreferences.pix.name,
          ),
        ).thenThrow(Exception());
        final result = cache.getTaxaPix();
        expect(result.isError(), true);
        expect(result.fold(id, id), isA<Exception>());
      });
    });
  });
}
