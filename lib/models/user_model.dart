class UserModel {
  final String uid;
  final String name;
  final String email;
  final String role;
  final int stars;
  final String? teacherCode;
  final String? childName;
  final int? childAge;

  UserModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.role,
    this.stars = 0,
    this.teacherCode,
    this.childName,
    this.childAge,
  });

  Map<String, dynamic> toJson() => {
        'uid': uid,
        'name': name,
        'email': email,
        'role': role,
        'stars': stars,
        'teacherCode': teacherCode,
        'childName': childName,
        'childAge': childAge,
      };

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json['uid'] ?? '',
      name: json['name'] ?? 'Guest',
      email: json['email'] ?? '',
      role: json['role'] ?? 'parent',
      stars: json['stars'] ?? 0,
      teacherCode: json['teacherCode'],
      childName: json['childName'],
      childAge: json['childAge'],
    );
  }
}
