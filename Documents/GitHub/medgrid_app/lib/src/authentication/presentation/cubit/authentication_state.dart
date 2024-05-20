part of 'authentication_cubit.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

class AuthenticationInitial extends AuthenticationState {
  const AuthenticationInitial();
}

class GettingDrug extends AuthenticationState {
  const GettingDrug();
}

class GetDrug extends AuthenticationState {
  const GetDrug(this.drugs, this.drugDetail, this.manufacturer);

  final List<Drug> drugs;
  final Manufacturer manufacturer;
  final DrugDetail drugDetail;

  @override
  List<Object> get props => [drugs.map((user) => user.id).toList(), drugDetail.expiration, manufacturer.name];
}

class GettingDrugInfo extends AuthenticationState {
  const GettingDrugInfo();
}

class LoadedDrugDetail extends AuthenticationState {
  const LoadedDrugDetail(this.drugDetail);

  final DrugDetail drugDetail;

  @override
  List<Object> get props => [drugDetail.expiration];  // Return a list containing all relevant fields
}

class GettingManufacturer extends AuthenticationState {
  const GettingManufacturer();
}

class LoadedManufacturer extends AuthenticationState {
  const LoadedManufacturer(this.manufacturer);

  final Manufacturer manufacturer;

  @override
  List<Object> get props => [manufacturer.name];
}

class AuthenticationError extends AuthenticationState {
  const AuthenticationError(this.message);

  final String message;

  @override
  List<String> get props => [message];
}
