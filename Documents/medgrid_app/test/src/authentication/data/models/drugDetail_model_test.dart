import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:medgrid_app/core/utils/typedef.dart';
import 'package:medgrid_app/src/authentication/data/models/drugDetail_model.dart';
import 'package:medgrid_app/src/authentication/domain/entities/drugDetail.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  const tModel = DrugDetailModel.empty();

  test('should be a subclass of [Manufacturer] entity', () {
    // Act

    // Assert
    expect(tModel, isA<DrugDetail>());
  });

  final tJson = fixture('drugDetail.json');
  final tMap = jsonDecode(tJson) as DataMap;

  group('fromMap', () {
    test('should return a [DrugDetailModel] with the right data', () {
      // Act
      final result = DrugDetailModel.fromMap(tMap);
      expect(result, equals(tModel));
    });
  });

  group('fromJson', () {
    test('should return a [DrugDetailModel] with the right data', () {
      // Act
      final result = DrugDetailModel.fromJson(tJson);
      expect(result, equals(tModel));
    });
  });

  group('toMap', () {
    test('should return a [map] with the right data', () {
      // Act
      final result = tModel.toMap();

      // Assert
      expect(result, equals(tMap));
    });
  });

  group('toJson', () {
    test('should return a [JSON] string with the right data', () {
      // Act
      final result = tModel.toJson();
      final tJson = jsonEncode({
        "batch": {
          "lotNumber": "_empty.lotNumber",
          "expirationDate": "_empty.expiration"
        },
          "manufacturer": {
          "reference": "_empty.medicationForm"
        },
      });
      // Assert
      expect(result, equals(tJson));
    });
  });

  group('copyWith', () {
    test('should return a [Usermodel] with different data', () {
      // Arrange

      // Act
      final result = tModel.copyWith(expiration: 'Paul');

      expect(result.expiration, equals('Paul'));
    });
  });
}
