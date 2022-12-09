import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
class User with _$User {

  @JsonSerializable(
    fieldRename: FieldRename.snake,
  )
  const factory User({
    required int id,
    required String email,
    required String firstName,
    required String lastName,
    required String avatar,
  }) = _User;

  factory User.fromJson(Map<String, Object?> json)
  => _$UserFromJson(json);
}