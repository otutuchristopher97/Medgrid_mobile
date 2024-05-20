import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:medgrid_app/src/authentication/domain/entities/drugDetail.dart';
import 'package:medgrid_app/src/authentication/domain/repositories/authentication_repository.dart';
import 'package:medgrid_app/src/authentication/domain/usecases/drug_info.dart';
import 'package:mocktail/mocktail.dart';

import 'authentication_repository.mock.dart';

void main() {
  late GetDrugDetailInfo usecase;
  late AuthenticationRepository repository;

  setUp(() {
    repository = MockAuthRepo();
    usecase = GetDrugDetailInfo(repository);
  });

  const drugDetail = DrugDetail.empty();
  const params = DrugInfoDetailParams.empty();
  test('should call the [Reposity.getDrugInfo]', () async {
    // Arrange
    // STUB
    when(() => repository.getDrugInfoDetail(
      txharsh: any(named: 'txharsh')
      ))
      .thenAnswer((_) async => const Right(drugDetail));
    // Act
    final result = await usecase(params);

    // Assert
    expect(result, equals(const Right<dynamic, DrugDetail>(drugDetail)));
    verify(() => repository.getDrugInfoDetail(txharsh: any(named: 'txharsh'))).called(1);

    verifyNoMoreInteractions(repository);
  });
}
