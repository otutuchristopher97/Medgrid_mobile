import 'dart:convert';

import 'package:medgrid_app/core/utils/typedef.dart';
import 'package:medgrid_app/src/authentication/domain/entities/drug.dart';

class DrugModel extends Drug {
  const DrugModel({
    required super.cid,
    required super.id,
    required super.createdAt,
    required super.orgCid,
    required super.sid,
    required super.trxHash,
    required super.uuid,
  });

  const DrugModel.empty()
      : this(
            id: '1',
            createdAt: '_empty.createdAt',
            cid: '_empty.cid',
            orgCid: '_empty.orgCid',
            sid: '_empty.sid',
            trxHash: '_empty.trxHash',
            uuid: '_empty.uuid'
            );

  factory DrugModel.fromJson(String source) =>
      DrugModel.fromMap(jsonDecode(source) as DataMap);

  DrugModel.fromMap(DataMap map)
      : this(
            cid: map['attributes']['cid'] as String,
            id: map['id'].toString(),
            createdAt: map['attributes']['createdAt'] as String,
            trxHash: map['attributes']['trxHash'] as String,
            sid: map['attributes']['sid'] as String,
            uuid: map['attributes']['uuid'] as String,
            orgCid: map['attributes']['orgCid'] as String,
          );

  DrugModel copyWith({
    String? cid,
    String? id,
    String? createdAt,
    String? trxHash,
    String? uuid,
    String? orgCid,
    String? sid,
  }) {
    return DrugModel(
      cid: cid ?? this.cid, 
      id: id ?? this.id, 
      createdAt: createdAt ?? this.createdAt, 
      sid: sid ?? this.sid,
      uuid: uuid ?? this.uuid,
      trxHash: trxHash ?? this.trxHash,
      orgCid: orgCid ?? this.orgCid,
    );
  }

  DataMap toMap() => {
        'id': id,
        'attributes': {
          'cid': cid,
          'createdAt': createdAt,
          'sid': sid,
          'uuid': uuid,
          'trxHash': trxHash,
          'orgCid': orgCid
        }
      };

  String toJson() => jsonEncode(toMap());
}
