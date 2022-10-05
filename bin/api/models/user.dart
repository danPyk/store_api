import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  final String name;

  final String email;

  final String password;

  final String? salt;
  final String id;

  User(
      {required this.name,
      required this.email,
      required this.password,
      required this.id,
   this.salt});

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
