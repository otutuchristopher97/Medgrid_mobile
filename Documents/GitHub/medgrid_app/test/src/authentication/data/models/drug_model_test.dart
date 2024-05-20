import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:medgrid_app/core/utils/typedef.dart';
import 'package:medgrid_app/src/authentication/data/models/drug_model.dart';
import 'package:medgrid_app/src/authentication/domain/entities/drug.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  const tModel = DrugModel.empty();

  test('should be a subclass of [User] entity', () {
    // Act

    // Assert
    expect(tModel, isA<Drug>());
  });

  final tJson = fixture('drug.json');
  final tMap = jsonDecode(tJson) as DataMap;

  group('fromMap', () {
    test('should return a [DrugModel] with the right data', () {
      // Act
      final result = DrugModel.fromMap(tMap);
      expect(result, equals(tModel));
    });
  });

  group('fromJson', () {
    test('should return a [DrugModel] with the right data', () {
      // Act
      final result = DrugModel.fromJson(tJson);
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
          "id": "1",
          "attributes": {
              "cid": "_empty.cid",
              "createdAt": "_empty.createdAt",
              "sid": "_empty.sid",
              "uuid": "_empty.uuid",
              "trxHash": "_empty.trxHash",
              "orgCid": "_empty.orgCid"
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
      final result = tModel.copyWith(trxHash: 'Paul');

      expect(result.trxHash, equals('Paul'));
    });
  });
}
