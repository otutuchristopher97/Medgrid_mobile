import 'dart:convert';

import 'package:medgrid_app/core/utils/typedef.dart';
import 'package:medgrid_app/src/authentication/domain/entities/manufacturer.dart';

class ManufacturerModel extends Manufacturer {
  const ManufacturerModel({
    required super.address,
    required super.email,
    required super.name,
    required super.phone
  });

  const ManufacturerModel.empty()
      : this(
          address: '_empty.address',
          email: '_empty.email',
          name: '_empty.name',
          phone: '_empty.phone'
    );

  factory ManufacturerModel.fromJson(String source) =>
      ManufacturerModel.fromMap(jsonDecode(source) as DataMap);

  ManufacturerModel.fromMap(DataMap map)
      : this(
            address: map['orgData']['address'][0]['text'] as String,
            email: map['orgData']['telecom'][1]['value'].toString(),
            name: map['orgData']['name'] as String,
            phone: map['orgData']['telecom'][0]['value'] as String
          );

  ManufacturerModel copyWith({
    String? address,
    String? email,
    String? name,
    String? phone
  }) {
    return ManufacturerModel(
      address: address ?? this.address, 
      email: email ?? this.email, 
      name: name ?? this.name,
      phone: name ?? this.phone,
    );
  }

  DataMap toMap() => {
      "orgData": {
          "address": [
              {
                  "text": address
              }
          ],
          "name": name,
          "telecom": [
              {"value": phone},
              {"value": email}
          ]
      }
  };

  String toJson() => jsonEncode(toMap());
}

