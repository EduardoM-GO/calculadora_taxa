import 'package:calculadora_taxa/app/core/domain/entities/cartao_credito_taxa.dart';
import 'package:calculadora_taxa/app/core/domain/entities/taxa.dart';
import 'package:calculadora_taxa/app/core/domain/repositories/taxas_repository.dart';
import 'package:calculadora_taxa/app/core/domain/use_cases/set_taxas_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:result_dart/functions.dart';
import 'package:result_dart/result_dart.dart';

class _TaxasRepositoryMock extends Mock implements TaxasRepository {}

void main() {
  late SetTaxasUseCase useCase;
  late TaxasRepository repository;
  late CartaoCreditoTaxa cartaoCreditoTaxa;
  late Taxa cartaoTaxa;
  late Taxa pixTaxa;

  setUp(() {
    repository = _TaxasRepositoryMock();
    cartaoCreditoTaxa = const CartaoCreditoTaxa(
      percentualTaxa: 1,
      percentualTaxaParcelado: 2.8,
    );
    cartaoTaxa = const Taxa(percentualTaxa: 2);
    pixTaxa = const Taxa(percentualTaxa: 3.33);
    useCase = SetTaxasUseCaseImpl(repository);
  });
  test('set taxas use case - ok', () async {
    when(
      () => repository.setTaxaCartaoCredito(taxa: cartaoCreditoTaxa),
    ).thenAnswer((_) async => const Success(unit));

    when(
      () => repository.setTaxaCartaoDebito(taxa: cartaoTaxa),
    ).thenAnswer((_) async => const Success(unit));

    when(
      () => repository.setTaxaPix(taxa: pixTaxa),
    ).thenAnswer((_) async => const Success(unit));

    final result = await useCase(
      cartaoCredito: cartaoCreditoTaxa,
      cartaoDebito: cartaoTaxa,
      pix: pixTaxa,
    );

    expect(result.isSuccess(), true);
    expect(result.fold(id, id), isA<Unit>());
  });

  group('set taxas use case - Erro -', () {
    test('setTaxaCartaoCredito', () async {
      when(
        () => repository.setTaxaCartaoCredito(taxa: cartaoCreditoTaxa),
      ).thenAnswer((_) async => Failure(Exception()));

      when(
        () => repository.setTaxaCartaoDebito(taxa: cartaoTaxa),
      ).thenAnswer((_) async => const Success(unit));

      when(
        () => repository.setTaxaPix(taxa: pixTaxa),
      ).thenAnswer((_) async => const Success(unit));

      final result = await useCase(
        cartaoCredito: cartaoCreditoTaxa,
        cartaoDebito: cartaoTaxa,
        pix: pixTaxa,
      );

      expect(result.isError(), true);
      expect(result.fold(id, id), isA<Exception>());
    });
    test('setTaxaCartaoDebito', () async {
      when(
        () => repository.setTaxaCartaoCredito(taxa: cartaoCreditoTaxa),
      ).thenAnswer((_) async => const Success(unit));

      when(
        () => repository.setTaxaCartaoDebito(taxa: cartaoTaxa),
      ).thenAnswer((_) async => Failure(Exception()));

      when(
        () => repository.setTaxaPix(taxa: pixTaxa),
      ).thenAnswer((_) async => const Success(unit));

      final result = await useCase(
        cartaoCredito: cartaoCreditoTaxa,
        cartaoDebito: cartaoTaxa,
        pix: pixTaxa,
      );

      expect(result.isError(), true);
      expect(result.fold(id, id), isA<Exception>());
    });
    test('setTaxaPix', () async {
      when(
        () => repository.setTaxaCartaoCredito(taxa: cartaoCreditoTaxa),
      ).thenAnswer((_) async => const Success(unit));

      when(
        () => repository.setTaxaCartaoDebito(taxa: cartaoTaxa),
      ).thenAnswer((_) async => const Success(unit));

      when(
        () => repository.setTaxaPix(taxa: pixTaxa),
      ).thenAnswer((_) async => Failure(Exception()));

      final result = await useCase(
        cartaoCredito: cartaoCreditoTaxa,
        cartaoDebito: cartaoTaxa,
        pix: pixTaxa,
      );

      expect(result.isError(), true);
      expect(result.fold(id, id), isA<Exception>());
    });
  });
}
