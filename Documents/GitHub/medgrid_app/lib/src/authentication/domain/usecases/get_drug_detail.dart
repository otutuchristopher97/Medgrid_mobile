import 'package:equatable/equatable.dart';
import 'package:medgrid_app/core/usecase/usecase.dart';
import 'package:medgrid_app/core/utils/typedef.dart';
import 'package:medgrid_app/src/authentication/domain/repositories/authentication_repository.dart';

class GetDrugDetail extends UsecaseWithParaams<void, DrugDetailParams> {
  const GetDrugDetail(this._repository);

  final AuthenticationRepository _repository;

  @override
  ResultFuture call(DrugDetailParams params) async => _repository.getDrugDetail(
      txharsh: params.txharsh);
}

class DrugDetailParams extends Equatable {
  const DrugDetailParams(
      {required this.txharsh});

  const DrugDetailParams.empty()
      : this(
            txharsh: '_empty.string');

  final String txharsh;

  @override
  List<Object?> get props => [txharsh];
}
