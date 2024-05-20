import 'package:equatable/equatable.dart';
import 'package:medgrid_app/core/usecase/usecase.dart';
import 'package:medgrid_app/core/utils/typedef.dart';
import 'package:medgrid_app/src/authentication/domain/repositories/authentication_repository.dart';

class GetDrugDetailInfo extends UsecaseWithParaams<void, DrugInfoDetailParams> {
  const GetDrugDetailInfo(this._repository);

  final AuthenticationRepository _repository;

  @override
  ResultFuture call(DrugInfoDetailParams params) async => _repository.getDrugInfoDetail(
      txharsh: params.txharsh);
}

class DrugInfoDetailParams extends Equatable {
  const DrugInfoDetailParams(
      {required this.txharsh});

  const DrugInfoDetailParams.empty()
      : this(
            txharsh: '_empty.string');

  final String txharsh;

  @override
  List<Object?> get props => [txharsh];
}
