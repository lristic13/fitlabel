import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
class User with _$User {
  const factory User({
    required String id,
    required String email,
    required String role,
    String? firstName,
    String? lastName,
    String? avatar,
    DateTime? dateOfBirth,
    required bool isPremium,
    String? tenantSlug,
    required DateTime dateJoined,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
