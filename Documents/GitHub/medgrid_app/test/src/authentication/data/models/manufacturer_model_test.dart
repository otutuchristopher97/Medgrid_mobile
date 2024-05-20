import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:medgrid_app/core/utils/typedef.dart';
import 'package:medgrid_app/src/authentication/data/models/manufacturer_model.dart';
import 'package:medgrid_app/src/authentication/domain/entities/manufacturer.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  const tModel = ManufacturerModel.empty();

  test('should be a subclass of [User] entity', () {
    // Act

    // Assert
    expect(tModel, isA<Manufacturer>());
  });

  final tJson = fixture('manufacturer.json');
  final tMap = jsonDecode(tJson) as DataMap;

  group('fromMap', () {
    test('should return a [ManufacturerModel] with the right data', () {
      // Act
      final result = ManufacturerModel.fromMap(tMap);
      expect(result, equals(tModel));
    });
  });

  group('fromJson', () {
    test('should return a [DrugDetailModel] with the right data', () {
      // Act
      final result = ManufacturerModel.fromJson(tJson);
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
          "orgData": {
              "address": [
                  {
                      "text": "_empty.address"
                  }
              ],
              "name": "_empty.name",
              "telecom": [
                  {"value": "_empty.phone"},
                  {"value": "_empty.email"}
              ]
          }
      });
      // Assert
      expect(result, equals(tJson));
    });
  });

  group('copyWith', () {
    test('should return a [Usermodel] with different data', () {
      // Arrange

      // Act
      final result = tModel.copyWith(name: 'Paul');

      expect(result.name, equals('Paul'));
    });
  });
}
