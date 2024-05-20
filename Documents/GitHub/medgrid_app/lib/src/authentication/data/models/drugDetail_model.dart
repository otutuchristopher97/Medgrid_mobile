import 'dart:convert';

import 'package:medgrid_app/core/utils/typedef.dart';
import 'package:medgrid_app/src/authentication/domain/entities/drugDetail.dart';

class DrugDetailModel extends DrugDetail {
  const DrugDetailModel({
    required super.expiration,
    required super.medicationForm,
    required super.packageNumber,
  });

  const DrugDetailModel.empty()
      : this(
            expiration: '_empty.expiration',
            medicationForm: '_empty.medicationForm',
            packageNumber: '_empty.lotNumber'
            );

  factory DrugDetailModel.fromJson(String source) =>
      DrugDetailModel.fromMap(jsonDecode(source) as DataMap);

  DrugDetailModel.fromMap(DataMap map)
      : this(
            packageNumber: map['batch']['lotNumber'] as String,
            medicationForm: map['manufacturer']['reference'].toString(),
            expiration: map['batch']['expirationDate'] as String
          );

  DrugDetailModel copyWith({
    String? expiration,
    String? packageNumber,
    String? medicationForm
  }) {
    return DrugDetailModel(
      expiration: expiration ?? this.expiration, 
      packageNumber: packageNumber ?? this.packageNumber, 
      medicationForm: medicationForm ?? this.medicationForm,
    );
  }

  DataMap toMap() => {
        "batch": {
                  "lotNumber": packageNumber,
                  "expirationDate": expiration
              },
              "manufacturer": {
                  "reference": medicationForm
              },
      };

  String toJson() => jsonEncode(toMap());
}

