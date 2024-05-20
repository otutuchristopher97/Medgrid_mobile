import 'package:equatable/equatable.dart';

class Manufacturer extends Equatable {
  const Manufacturer(
      {required this.email,
      required this.phone,
      required this.name,
      required this.address});

  const Manufacturer.empty()
      : this(
            email: '1',
            phone: '_empty.createdAt',
            name: '_empty.name',
            address: '_empty.avatar');

  final String email;
  final String phone;
  final String name;
  final String address;

  @override
  List<Object?> get props => [email, name, phone, address];
}
