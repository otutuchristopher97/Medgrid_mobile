import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:medgrid_app/src/authentication/domain/entities/drug.dart';
import 'package:medgrid_app/src/authentication/domain/entities/drugDetail.dart';
import 'package:medgrid_app/src/authentication/domain/entities/manufacturer.dart';
import 'package:medgrid_app/src/authentication/domain/usecases/get_drug_detail.dart';
import 'package:medgrid_app/src/authentication/domain/usecases/drug_info.dart';
import 'package:medgrid_app/src/authentication/domain/usecases/manufacturer_usecase.dart';

part 'authentication_state.dart';

class AuthenticaationCubit extends Cubit<AuthenticationState> {
  AuthenticaationCubit({
    required GetDrugDetail getDrugDetail,
    required GetDrugDetailInfo getDrugDetailInfo,
    required GetManufacturerDetail getManufacturerDetail,
  })  : _getDrugDetail = getDrugDetail,
        _getDrugDetailInfo = getDrugDetailInfo,
        _getManufacturerDetail = getManufacturerDetail,
        super(AuthenticationInitial());

  final GetDrugDetail _getDrugDetail;
  final GetDrugDetailInfo _getDrugDetailInfo;
  final GetManufacturerDetail _getManufacturerDetail;

  Future<void> getDrugDetailFromDB({
    required String txharsh
  }) async {
    emit(const GettingDrug());

    final result = await _getDrugDetail(
        DrugDetailParams(txharsh: txharsh));

    result.fold(
        (failure) => emit(AuthenticationError(failure.message)),
        (drugs)async {
          final drugDetail = await getDrugDetailInfo(txharsh: drugs[0].cid);
          final manufacturer = await getManufacturerDetail(txharsh: drugs[0].orgCid);
          emit(GetDrug(drugs, drugDetail, manufacturer));
        });
  }

  Future<DrugDetail> getDrugDetailInfo({
    required String txharsh
  }) async {
    emit(const GettingDrugInfo());

    final result = await _getDrugDetailInfo(DrugInfoDetailParams(txharsh: txharsh));

    return result.fold((failure) {
      emit(AuthenticationError(failure.message));
        throw Exception(failure.message);
      },
        (drug){
          emit(LoadedDrugDetail(drug));
          return drug;
        });
  }

  Future<Manufacturer> getManufacturerDetail({
    required String txharsh
  }) async {
    emit(const GettingManufacturer());

    final result = await _getManufacturerDetail(ManufacturerDetailParams(txharsh: txharsh));

    return result.fold((failure) { 
      emit(AuthenticationError(failure.message));
      throw Exception(failure.message);
    },
        (manufacturer) {
          emit(LoadedManufacturer(manufacturer));
          return manufacturer;
        });
  }
}
