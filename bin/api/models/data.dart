import 'package:json_annotation/json_annotation.dart';

import 'user.dart';

part 'data.g.dart';

@JsonSerializable()
class Data {
  final String token;
//todo

  ///null, because when sign up we do not supply id
  final String? id;
  final Map<String, dynamic> userMap;

  Data({
    required this.token,
    required this.userMap,
    this.id,
  });

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}
