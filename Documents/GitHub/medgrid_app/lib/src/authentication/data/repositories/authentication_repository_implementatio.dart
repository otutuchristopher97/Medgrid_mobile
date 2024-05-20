import 'package:dartz/dartz.dart';
import 'package:medgrid_app/core/errors/exceptions.dart';
import 'package:medgrid_app/core/errors/failure.dart';
import 'package:medgrid_app/core/utils/typedef.dart';
import 'package:medgrid_app/src/authentication/data/datasources/authentication_remote_data_source.dart';
import 'package:medgrid_app/src/authentication/data/models/drugDetail_model.dart';
import 'package:medgrid_app/src/authentication/domain/entities/drug.dart';
import 'package:medgrid_app/src/authentication/domain/entities/manufacturer.dart';
import 'package:medgrid_app/src/authentication/domain/repositories/authentication_repository.dart';

class AuthenticationRepositoryImplementation
    implements AuthenticationRepository {
  const AuthenticationRepositoryImplementation(this._remoteDataSource);

  final AuthenticationRemoteDatasource _remoteDataSource;

  @override
  ResultFuture<List<Drug>> getDrugDetail(
      {required String txharsh}) async {
    try {
      final result = await _remoteDataSource.getDrugDetail(
          txharsh: txharsh);
      return Right(result);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }

  @override
  ResultFuture<Manufacturer> getManufacturerDrugInfoDetail({required String txharsh}) async {
    try {
      final result = await _remoteDataSource.getManufacturerInfo(txharsh: txharsh);
      return Right(result as Manufacturer);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }
  
  @override
  ResultFuture<DrugDetailModel> getDrugInfoDetail({required String txharsh}) async{
    try {
      final result = await _remoteDataSource.getDrugInfo(txharsh: txharsh);
      return Right(result);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }
  
}
