import 'dart:core';
class User {
  final String id;
  final String name;
  final String phone;
   String avatar;
  final String email;
  final String gender;
  final DateTime dob;
  final String address;
  final String city;
  final String pincode;
  final String state;
  final String profession;
  final String familyId;
  final bool married;
  DateTime? anniv;
  bool editRequest;

  User(
      {required this.id,
      required this.name,
      required this.phone,
      this.avatar = '',
      required this.email,
      required this.dob,
      this.anniv,
      required this.profession,
      required this.address,
      required this.city,
      required this.pincode,
      required this.state,
      required this.familyId,
      required this.gender,
      required this.married,
      this.editRequest = false,
      });
}
