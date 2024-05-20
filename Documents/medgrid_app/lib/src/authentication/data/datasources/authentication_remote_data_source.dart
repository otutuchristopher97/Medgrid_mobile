import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:medgrid_app/core/errors/exceptions.dart';
import 'package:medgrid_app/core/utils/constants.dart';
import 'package:medgrid_app/core/utils/typedef.dart';
import 'package:medgrid_app/src/authentication/data/models/drugDetail_model.dart';
import 'package:medgrid_app/src/authentication/data/models/drug_model.dart';
import 'package:medgrid_app/src/authentication/data/models/manufacturer_model.dart';

abstract class AuthenticationRemoteDatasource {
  Future<List<DrugModel>> getDrugDetail(
      {required String txharsh});

  Future<ManufacturerModel> getManufacturerInfo(
      {required String txharsh});

  Future<DrugDetailModel> getDrugInfo(
      {required String txharsh});
}

const kGetDrugEndpoint = '/test-api/users';
const KGetUserEndpoint = '/test-api/users';

class AuthRemoteDataSrcImpl implements AuthenticationRemoteDatasource {
  const AuthRemoteDataSrcImpl(this._client);

  final http.Client _client;

  @override
  Future<List<DrugModel>> getDrugDetail(
      {required String txharsh}) async {
    //1. check to make sure that it return the right data when the status
    // is 200 or the proper reponse code
    // 2. check to make sure that it "THROWS A CUSTOM EXCEPTION" with the
    // right message when status code is the bad one
    
    var url = Uri.parse(KBaseUrl+ txharsh);

    try {
      final response =
          await _client.get(url,
              headers: {'Content-Type': 'application/json', 'Authorization': 'Bearer $bearToken',});

      if (response.statusCode != 200) {
        throw APIException(
            message: response.body, statusCode: response.statusCode);
      }
      return List<DataMap>.from(jsonDecode(response.body)['data'] as List)
          .map((userData) => DrugModel.fromMap(userData))
          .toList();
    } on APIException {
      rethrow;
    } catch (e) {
      throw APIException(message: e.toString(), statusCode: 505);
    }
  }

  @override
  Future<ManufacturerModel> getManufacturerInfo(
  {required String txharsh}) async {
    
    var url = Uri.parse(KIPFX + txharsh);

    try {
      final response =
          await _client.get(url,
              headers: {'Content-Type': 'application/json'});
      print(response.body);
      if (response.statusCode != 200) {
        throw APIException(
            message: response.body, statusCode: response.statusCode);
      }
      return ManufacturerModel.fromMap(jsonDecode(response.body));
    } on APIException {
      rethrow;
    } catch (e) {
      throw APIException(message: e.toString(), statusCode: 505);
    }
  }

  @override
  Future<DrugDetailModel> getDrugInfo(
  {required String txharsh}) async {
    
    var url = Uri.parse(KIPFX + txharsh);

    try {
      final response =
          await _client.get(url,
              headers: {'Content-Type': 'application/json'});
      print(response.body);
      if (response.statusCode != 200) {
        throw APIException(
            message: response.body, statusCode: response.statusCode);
      }
      return DrugDetailModel.fromMap(jsonDecode(response.body));
    } on APIException {
      rethrow;
    } catch (e) {
      throw APIException(message: e.toString(), statusCode: 505);
    }
  }

}
