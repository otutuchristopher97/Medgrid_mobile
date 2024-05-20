// what does the class depend on
//Answer -- AuthenticationRepository
//how can we create a fake version of the dependency
//Answer -- Use Mocktail
//How do we control what our dependencies do
//Answer -- Using the Mocktail's APIs

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:medgrid_app/src/authentication/domain/entities/drug.dart';
import 'package:medgrid_app/src/authentication/domain/repositories/authentication_repository.dart';
import 'package:medgrid_app/src/authentication/domain/usecases/get_drug_detail.dart';
import 'package:mocktail/mocktail.dart';

import 'authentication_repository.mock.dart';


void main() {
  late GetDrugDetail usecase;
  late AuthenticationRepository repository;

  setUp(() {
    repository = MockAuthRepo();
    usecase = GetDrugDetail(repository);
  });

  const drug = [Drug.empty()];
  const params = DrugDetailParams.empty();
  test('should call the [Reposity.createUser]', () async {
    // Arrange
    // STUB
    when(() => repository.getDrugDetail(
      txharsh: any(named: 'txharsh')
      ))
      .thenAnswer((_) async => const Right(drug));
    // Act
    final result = await usecase(params);

    // Assert
    expect(result, equals(const Right<dynamic, List<Drug>>(drug)));
    verify(() => repository.getDrugDetail(txharsh: any(named: 'txharsh'))).called(1);

    verifyNoMoreInteractions(repository);
  });
}
