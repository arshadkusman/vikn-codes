import 'package:equatable/equatable.dart';

class LoginEntity extends Equatable {
  final String token;
  final String userId;

  const LoginEntity({
    required this.token,
    required this.userId,
  });

  @override
  List<Object?> get props => [token, userId];
}
