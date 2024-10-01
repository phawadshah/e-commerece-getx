// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class SingupModel {
  String? name;
  String? email;
  String? password;
  SingupModel({
    this.name,
    this.email,
    this.password,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'email': email,
      'password': password,
    };
  }

  factory SingupModel.fromMap(Map<String, dynamic> map) {
    return SingupModel(
      name: map['name'] as String,
      email: map['email'] as String,
      password: map['password'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory SingupModel.fromJson(String source) =>
      SingupModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'SingupModel(email: $email, password: $password)';
}
