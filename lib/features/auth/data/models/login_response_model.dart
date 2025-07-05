// features/auth/data/models/login_response_model.dart
import '../../domain/entities/login_entity.dart';

class LoginResponseModel extends LoginEntity {
  LoginResponseModel({required String token, required String userId})
    : super(token: token, userId: userId);

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    // Drill into the nested "data" map
    final data =
        json['data'] as Map<String, dynamic>? ??
        (throw FormatException('LoginResponseModel: missing data'));

    // Your token is under "access"
    final rawToken = data['access'] as String?;
    if (rawToken == null) {
      throw FormatException('LoginResponseModel: missing token in data: $data');
    }

    // Your user ID is under data['user_id']
    final uid = data['user_id'];
    if (uid == null) {
      throw FormatException(
        'LoginResponseModel: missing user_id in data: $data',
      );
    }

    return LoginResponseModel(token: rawToken, userId: uid.toString());
  }
}
