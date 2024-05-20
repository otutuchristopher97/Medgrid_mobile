import 'package:equatable/equatable.dart';

class DrugDetail extends Equatable {
  const DrugDetail(
      {required this.expiration,
      required this.packageNumber,
      required this.medicationForm});

  const DrugDetail.empty()
      : this(
            expiration: '1',
            packageNumber: '_empty.createdAt',
            medicationForm: '_empty.name');

  final String expiration;
  final String packageNumber;
  final String medicationForm;

  @override
  List<Object?> get props => [expiration, packageNumber, medicationForm];
}
