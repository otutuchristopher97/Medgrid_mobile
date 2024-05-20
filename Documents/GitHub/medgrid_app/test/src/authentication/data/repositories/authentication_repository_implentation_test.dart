import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:medgrid_app/core/errors/exceptions.dart';
import 'package:medgrid_app/core/errors/failure.dart';
import 'package:medgrid_app/src/authentication/data/datasources/authentication_remote_data_source.dart';
import 'package:medgrid_app/src/authentication/data/models/drugDetail_model.dart';
import 'package:medgrid_app/src/authentication/data/models/manufacturer_model.dart';
import 'package:medgrid_app/src/authentication/data/repositories/authentication_repository_implementatio.dart';
import 'package:medgrid_app/src/authentication/domain/entities/drug.dart';
import 'package:medgrid_app/src/authentication/domain/entities/manufacturer.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRemoteDataSrc extends Mock
    implements AuthenticationRemoteDatasource {}

void main() {
  late AuthenticationRemoteDatasource remoteDataSource;
  late AuthenticationRepositoryImplementation repoImpl;
  setUp(() {
    remoteDataSource = MockAuthRemoteDataSrc();
    repoImpl = AuthenticationRepositoryImplementation(remoteDataSource);
  });

  const tException =
      APIException(message: 'Unknown Error Occur', statusCode: 500);
  group('getDrugDetail', () {
    const txharsh = 'whatever.txharsh';
    test(
      'should call the [RemoteDataSource.getDrugDetail] and complete'
      'successfully when the call to the remote source is successful',
      () async {
        // arrange
        when(() => remoteDataSource.getDrugDetail(
                txharsh: any(named: 'txharsh')))
            .thenAnswer((_) async => []);

        // act
        final result = await repoImpl.getDrugDetail(
            txharsh: txharsh);

        // assert
        expect(result, isA<Right<Failure, List<Drug>>>());
        verify(() => remoteDataSource.getDrugDetail(
            txharsh: txharsh)).called(1);
        verifyNoMoreInteractions(remoteDataSource);
      },
    );

    test(
        'should return a [ServerFailure] when the call to the remote source is unseccessful',
        () async {
      // arrange
      when(() => remoteDataSource.getDrugDetail(
          txharsh: any(named: 'txharsh'))).thenThrow(tException);

      final result = await repoImpl.getDrugDetail(
          txharsh: txharsh);

      expect(
          result,
          equals(Left(APIFailure(
              message: tException.message,
              statusCode: tException.statusCode))));

      verify(() => remoteDataSource.getDrugDetail(
          txharsh: txharsh)).called(1);

      verifyNoMoreInteractions(remoteDataSource);
    });
  });

  group('getDrugInfo', () {
    const txharsh = 'some_txharsh_value';
  test(
    'should call the [RemoteDataSource.getDrugInfo] and complete'
    ' successfully when the call to the remote source is successful',
    () async {
      // arrange
      const drugDetailModel = DrugDetailModel(
        expiration: '2025-12-31', 
        medicationForm: 'tablet', 
        packageNumber: '12345'
      );
      when(() => remoteDataSource.getDrugInfo(txharsh: any(named: 'txharsh')))
          .thenAnswer((_) async => drugDetailModel);

      // act
      final result = await repoImpl.getDrugInfoDetail(txharsh: txharsh);
      
      // assert
      expect(result, isA<Right<Failure, DrugDetailModel>>());
      
      verify(() => remoteDataSource.getDrugInfo(txharsh: txharsh)).called(1);
      verifyNoMoreInteractions(remoteDataSource);
    },
  );


    test(
        'should return a [ServerFailure] when the call to the remote source is unseccessful',
        () async {
      // arrange
      when(() => remoteDataSource.getDrugInfo(
          txharsh: any(named: 'txharsh'))).thenThrow(tException);

      final result = await repoImpl.getDrugInfoDetail(
          txharsh: txharsh);

      expect(
          result,
          equals(Left(APIFailure(
              message: tException.message,
              statusCode: tException.statusCode))));

      verify(() => remoteDataSource.getDrugInfo(
          txharsh: txharsh)).called(1);

      verifyNoMoreInteractions(remoteDataSource);
    });
  });

  group('getManufacturer', () {
    const txharsh = 'some_txharsh_value';
  test(
    'should call the [RemoteDataSource.getManufacturer] and complete'
    ' successfully when the call to the remote source is successful',
    () async {
      // arrange
      const manufacturerModel = ManufacturerModel(
        address: '5 darnley street', 
        phone: '0908483930', 
        email: 'gm@gmail.com', 
        name: 'chris'
      );
      when(() => remoteDataSource.getManufacturerInfo(txharsh: any(named: 'txharsh')))
          .thenAnswer((_) async => manufacturerModel);

      // act
      final result = await repoImpl.getManufacturerDrugInfoDetail(txharsh: txharsh);
      
      // assert
      expect(result, isA<Right<Failure, Manufacturer>>());
      
      verify(() => remoteDataSource.getManufacturerInfo(txharsh: txharsh)).called(1);
      verifyNoMoreInteractions(remoteDataSource);
    },
  );


    test(
        'should return a [ServerFailure] when the call to the remote source is unseccessful',
        () async {
      // arrange
      when(() => remoteDataSource.getManufacturerInfo(
          txharsh: any(named: 'txharsh'))).thenThrow(tException);

      final result = await repoImpl.getManufacturerDrugInfoDetail(
          txharsh: txharsh);

      expect(
          result,
          equals(Left(APIFailure(
              message: tException.message,
              statusCode: tException.statusCode))));

      verify(() => remoteDataSource.getManufacturerInfo(
          txharsh: txharsh)).called(1);

      verifyNoMoreInteractions(remoteDataSource);
    });
  });


}
