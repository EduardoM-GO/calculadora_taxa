import 'package:calculadora_taxa/app/core/domain/entities/cartao_credito_taxa.dart';
import 'package:calculadora_taxa/app/core/domain/entities/taxa.dart';
import 'package:calculadora_taxa/app/core/domain/repositories/taxas_repository.dart';
import 'package:calculadora_taxa/app/core/infra/cache/taxas_cache.dart';
import 'package:calculadora_taxa/app/core/infra/repositories/taxas_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:result_dart/functions.dart';
import 'package:result_dart/result_dart.dart';

class _TaxasCacheMock extends Mock implements TaxasCache {}

void main() {
  late TaxasCache cache;
  late CartaoCreditoTaxa cartaoCreditoTaxa;
  late Taxa cartaoTaxa;
  late Taxa pixTaxa;
  late TaxasRepository repository;

  setUp(() {
    cache = _TaxasCacheMock();
    cartaoCreditoTaxa = const CartaoCreditoTaxa(
      percentualTaxa: 1,
      percentualTaxaParcelado: 2.8,
      percentualTaxaPorParcela: 3.6,
    );
    cartaoTaxa = const Taxa(percentualTaxa: 2);
    pixTaxa = const Taxa(percentualTaxa: 3.33);
    repository = TaxasRepositoryImpl(cache);
  });

  group('taxas repository - Cartão Credito -', () {
    group('set -', () {
      test('Ok', () async {
        when(() => cache.setTaxaCartaoCredito(taxa: cartaoCreditoTaxa))
            .thenAnswer((_) async => const Success(unit));
        final result =
            await repository.setTaxaCartaoCredito(taxa: cartaoCreditoTaxa);

        expect(result.isSuccess(), true);
        expect(result.fold(id, id), isA<Unit>());
      });
      test('Erro', () async {
        when(() => cache.setTaxaCartaoCredito(taxa: cartaoCreditoTaxa))
            .thenAnswer((_) async => Failure(Exception()));
        final result =
            await repository.setTaxaCartaoCredito(taxa: cartaoCreditoTaxa);

        expect(result.isError(), true);
        expect(result.fold(id, id), isA<Exception>());
      });
    });
    group('get -', () {
      test('Ok', () {
        when(() => cache.getTaxaCartaoCredito())
            .thenReturn(Success(cartaoCreditoTaxa));
        final result = repository.getTaxaCartaoCredito();

        expect(result.isSuccess(), true);
        expect(result.fold(id, id), isA<CartaoCreditoTaxa>());
        expect(result.fold(id, id), cartaoCreditoTaxa);
      });
      test('Erro', () {
        when(() => cache.getTaxaCartaoCredito())
            .thenReturn(Failure(Exception()));
        final result = repository.getTaxaCartaoCredito();

        expect(result.isError(), true);
        expect(result.fold(id, id), isA<Exception>());
      });
    });
  });

  group('taxas repository - Cartão Debito -', () {
    group('set -', () {
      test('Ok', () async {
        when(() => cache.setTaxaCartaoDebito(taxa: cartaoTaxa))
            .thenAnswer((_) async => const Success(unit));
        final result = await repository.setTaxaCartaoDebito(taxa: cartaoTaxa);

        expect(result.isSuccess(), true);
        expect(result.fold(id, id), isA<Unit>());
      });
      test('Erro', () async {
        when(() => cache.setTaxaCartaoDebito(taxa: cartaoTaxa))
            .thenAnswer((_) async => Failure(Exception()));
        final result = await repository.setTaxaCartaoDebito(taxa: cartaoTaxa);

        expect(result.isError(), true);
        expect(result.fold(id, id), isA<Exception>());
      });
    });
    group('get -', () {
      test('Ok', () {
        when(() => cache.getTaxaCartaoDebito()).thenReturn(Success(cartaoTaxa));
        final result = repository.getTaxaCartaoDebito();

        expect(result.isSuccess(), true);
        expect(result.fold(id, id), isA<Taxa>());
        expect(result.fold(id, id), cartaoTaxa);
      });
      test('Erro', () {
        when(() => cache.getTaxaCartaoDebito())
            .thenReturn(Failure(Exception()));
        final result = repository.getTaxaCartaoDebito();

        expect(result.isError(), true);
        expect(result.fold(id, id), isA<Exception>());
      });
    });
  });

  group('taxas repository - Pix -', () {
    group('set -', () {
      test('Ok', () async {
        when(() => cache.setTaxaPix(taxa: pixTaxa))
            .thenAnswer((_) async => const Success(unit));
        final result = await repository.setTaxaPix(taxa: pixTaxa);

        expect(result.isSuccess(), true);
        expect(result.fold(id, id), isA<Unit>());
      });
      test('Erro', () async {
        when(() => cache.setTaxaPix(taxa: pixTaxa))
            .thenAnswer((_) async => Failure(Exception()));
        final result = await repository.setTaxaPix(taxa: pixTaxa);

        expect(result.isError(), true);
        expect(result.fold(id, id), isA<Exception>());
      });
    });
    group('get -', () {
      test('Ok', () {
        when(() => cache.getTaxaPix()).thenReturn(Success(pixTaxa));
        final result = repository.getTaxaPix();

        expect(result.isSuccess(), true);
        expect(result.fold(id, id), isA<Taxa>());
        expect(result.fold(id, id), pixTaxa);
      });
      test('Erro', () {
        when(() => cache.getTaxaPix()).thenReturn(Failure(Exception()));
        final result = repository.getTaxaPix();

        expect(result.isError(), true);
        expect(result.fold(id, id), isA<Exception>());
      });
    });
  });
}
