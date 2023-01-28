class Saathi {
  String userId;
  String name;
  String place;
  DateTime dob;
  String profession;
  String gender;
  String phone;
  String email;
  String? avatar;
  String? relation;

  Saathi({
    required this.userId,
    required this.dob,
    required this.profession,
    required this.place,
    required this.phone,
    required this.gender,
    required this.name,
    required this.email,
    this.avatar = '',
    this.relation = '',
  });
}
