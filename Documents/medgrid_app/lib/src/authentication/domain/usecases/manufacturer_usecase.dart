import 'package:equatable/equatable.dart';
import 'package:medgrid_app/core/usecase/usecase.dart';
import 'package:medgrid_app/core/utils/typedef.dart';
import 'package:medgrid_app/src/authentication/domain/repositories/authentication_repository.dart';

class GetManufacturerDetail extends UsecaseWithParaams<void, ManufacturerDetailParams> {
  const GetManufacturerDetail(this._repository);

  final AuthenticationRepository _repository;

  @override
  ResultFuture call(ManufacturerDetailParams params) async => _repository.getManufacturerDrugInfoDetail(
      txharsh: params.txharsh);
}

class ManufacturerDetailParams extends Equatable {
  const ManufacturerDetailParams(
      {required this.txharsh});

  const ManufacturerDetailParams.empty()
      : this(
            txharsh: '_empty.string');

  final String txharsh;

  @override
  List<Object?> get props => [txharsh];
}
