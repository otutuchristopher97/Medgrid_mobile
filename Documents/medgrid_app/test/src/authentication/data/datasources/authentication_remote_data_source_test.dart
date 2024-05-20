import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:medgrid_app/core/errors/exceptions.dart';
import 'package:medgrid_app/core/utils/constants.dart';
import 'package:medgrid_app/src/authentication/data/datasources/authentication_remote_data_source.dart';
import 'package:medgrid_app/src/authentication/data/models/drugDetail_model.dart';
import 'package:medgrid_app/src/authentication/data/models/drug_model.dart';
import 'package:medgrid_app/src/authentication/data/models/manufacturer_model.dart';

class MockClient extends Mock implements http.Client {}

void main() {
  late http.Client client;
  late AuthenticationRemoteDatasource remoteDatasource;

  setUp(() {
    client = MockClient();
    remoteDatasource = AuthRemoteDataSrcImpl(client);
    registerFallbackValue(Uri());
  });

  group('getDrugDetail', () {
    const txharsh = 'test_txharsh';
    final drugModels = [DrugModel.empty()];
    const tAPIFailureMessage = 'API Failure';

    test('should return List<DrugModel> when the status code is 200', () async {
      // Arrange
      when(() => client.get(any(), headers: any(named: 'headers')))
          .thenAnswer((_) async => http.Response(
              jsonEncode({'data': drugModels.map((e) => e.toMap()).toList()}),
              200));

      // Act
      final result = await remoteDatasource.getDrugDetail(txharsh: txharsh);

      // Assert
      expect(result, equals(drugModels));
      verify(() => client.get(Uri.parse(KBaseUrl + txharsh), headers: any(named: 'headers'))).called(1);
      verifyNoMoreInteractions(client);
    });

    test('should throw APIException when the status code is not 200', () async {
      // Arrange
      when(() => client.get(any(), headers: any(named: 'headers')))
          .thenAnswer((_) async => http.Response(tAPIFailureMessage, 400));

      // Act
      final call = remoteDatasource.getDrugDetail;

      // Assert
      expect(() => call(txharsh: txharsh),
          throwsA(isA<APIException>().having((e) => e.message, 'message', tAPIFailureMessage)));
      verify(() => client.get(Uri.parse(KBaseUrl + txharsh), headers: any(named: 'headers'))).called(1);
      verifyNoMoreInteractions(client);
    });
  });

  group('getManufacturerInfo', () {
    const txharsh = 'test_txharsh';
    final manufacturerModel = ManufacturerModel.empty();
    const tAPIFailureMessage = 'API Failure';

    test('should return ManufacturerModel when the status code is 200', () async {
      // Arrange
      when(() => client.get(any(), headers: any(named: 'headers')))
          .thenAnswer((_) async => http.Response(jsonEncode(manufacturerModel.toMap()), 200));

      // Act
      final result = await remoteDatasource.getManufacturerInfo(txharsh: txharsh);

      // Assert
      expect(result, equals(manufacturerModel));
      verify(() => client.get(Uri.parse(KIPFX + txharsh), headers: any(named: 'headers'))).called(1);
      verifyNoMoreInteractions(client);
    });

    test('should throw APIException when the status code is not 200', () async {
      // Arrange
      when(() => client.get(any(), headers: any(named: 'headers')))
          .thenAnswer((_) async => http.Response(tAPIFailureMessage, 400));

      // Act
      final call = remoteDatasource.getManufacturerInfo;

      // Assert
      expect(() => call(txharsh: txharsh),
          throwsA(isA<APIException>().having((e) => e.message, 'message', tAPIFailureMessage)));
      verify(() => client.get(Uri.parse(KIPFX + txharsh), headers: any(named: 'headers'))).called(1);
      verifyNoMoreInteractions(client);
    });
  });

  group('getDrugInfo', () {
    const txharsh = 'test_txharsh';
    final drugDetailModel = DrugDetailModel.empty();
    const tAPIFailureMessage = 'API Failure';

    test('should return DrugDetailModel when the status code is 200', () async {
      // Arrange
      when(() => client.get(any(), headers: any(named: 'headers')))
          .thenAnswer((_) async => http.Response(jsonEncode(drugDetailModel.toMap()), 200));

      // Act
      final result = await remoteDatasource.getDrugInfo(txharsh: txharsh);

      // Assert
      expect(result, equals(drugDetailModel));
      verify(() => client.get(Uri.parse(KIPFX + txharsh), headers: any(named: 'headers'))).called(1);
      verifyNoMoreInteractions(client);
    });

    test('should throw APIException when the status code is not 200', () async {
      // Arrange
      when(() => client.get(any(), headers: any(named: 'headers')))
          .thenAnswer((_) async => http.Response(tAPIFailureMessage, 400));

      // Act
      final call = remoteDatasource.getDrugInfo;

      // Assert
      expect(() => call(txharsh: txharsh),
          throwsA(isA<APIException>().having((e) => e.message, 'message', tAPIFailureMessage)));
      verify(() => client.get(Uri.parse(KIPFX + txharsh), headers: any(named: 'headers'))).called(1);
      verifyNoMoreInteractions(client);
    });
  });
}
