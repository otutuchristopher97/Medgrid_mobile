import 'package:equatable/equatable.dart';

class Drug extends Equatable {
  const Drug(
      {required this.id,
      required this.createdAt,
      required this.cid,
      required this.orgCid,
      required this.sid,
      required this.trxHash,
      required this.uuid
      });

  const Drug.empty()
      : this(
            id: '1',
            createdAt: '_empty.createdAt',
            cid: '_empty.cid',
            orgCid: '_empty.orgCid',
            sid: '_empty.sid',
            trxHash: '_empty.trxHash',
            uuid: '_empty.uuid'
            );

  final String id;
  final String createdAt;
  final String sid;
  final String cid;
  final String trxHash;
  final String orgCid;
  final String uuid;

  @override
  List<Object?> get props => [id, cid, sid, createdAt, orgCid, uuid, trxHash];
}
