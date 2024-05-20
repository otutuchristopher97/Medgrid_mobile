import 'package:medgrid_app/core/utils/typedef.dart';
import 'package:medgrid_app/src/authentication/domain/entities/drug.dart';
import 'package:medgrid_app/src/authentication/domain/entities/drugDetail.dart';
import 'package:medgrid_app/src/authentication/domain/entities/manufacturer.dart';

abstract class AuthenticationRepository {
  const AuthenticationRepository();

  ResultFuture<List<Drug>> getDrugDetail(
      {required String txharsh});
  ResultFuture<DrugDetail> getDrugInfoDetail(
      {required String txharsh});
  ResultFuture<Manufacturer> getManufacturerDrugInfoDetail(
      {required String txharsh});
}
