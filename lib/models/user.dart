// ignore_for_file: public_member_api_docs, sort_constructors_first

class UserModel {
  String name;
  String uid;
  String email;
  UserModel({
    required this.name,
    required this.uid,
    required this.email,
  });

  UserModel copyWith({
    String? name,
    String? uid,
    String? email,
  }) {
    return UserModel(
      name: name ?? this.name,
      uid: uid ?? this.uid,
      email: email ?? this.email,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'uid': uid,
      'email': email,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'] as String,
      uid: map['uid'] as String,
      email: map['email'] as String,
    );
  }
}
