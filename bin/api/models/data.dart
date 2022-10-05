import 'package:json_annotation/json_annotation.dart';

import 'user.dart';

part 'data.g.dart';

@JsonSerializable()
class Data {
  final String token;

  ///when sign up we do not supply id
  final String? id;
  final Map<String, dynamic> user;

  /// The generated code below handles if the corresponding JSON value doesn't
  /// exist or is empty.

  Data({
    required this.token,
    required this.user,
     this.id,
  });

  /// Connect the generated [_$UserFromJson] function to the `fromJson`
  /// factory.
  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$DataToJson(this);
}
