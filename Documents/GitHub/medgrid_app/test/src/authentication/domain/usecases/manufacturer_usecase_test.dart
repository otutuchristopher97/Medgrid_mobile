import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:medgrid_app/src/authentication/domain/entities/manufacturer.dart';
import 'package:medgrid_app/src/authentication/domain/repositories/authentication_repository.dart';
import 'package:medgrid_app/src/authentication/domain/usecases/manufacturer_usecase.dart';
import 'package:mocktail/mocktail.dart';

import 'authentication_repository.mock.dart';

void main() {
  late GetManufacturerDetail usecase;
  late AuthenticationRepository repository;

  setUp(() {
    repository = MockAuthRepo();
    usecase = GetManufacturerDetail(repository);
  });

  const manufacturer = Manufacturer.empty();
  const params = ManufacturerDetailParams.empty();
  test('should call the [Reposity.getDrugInfo]', () async {
    // Arrange
    // STUB
    when(() => repository.getManufacturerDrugInfoDetail(
      txharsh: any(named: 'txharsh')
      ))
      .thenAnswer((_) async => const Right(manufacturer));
    // Act
    final result = await usecase(params);

    // Assert
    expect(result, equals(const Right<dynamic, Manufacturer>(manufacturer)));
    verify(() => repository.getManufacturerDrugInfoDetail(txharsh: any(named: 'txharsh'))).called(1);

    verifyNoMoreInteractions(repository);
  });
}
