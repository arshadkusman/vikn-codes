// features/profile/domain/entities/profile.dart
import 'package:equatable/equatable.dart';

class Profile extends Equatable {
  final String id;
  final String name;
  final String email;
  final String avatarUrl;
  final double rating;      // new
  final int ridesCount;     // new
  final bool kycVerified;   // new

  const Profile({
    required this.id,
    required this.name,
    required this.email,
    required this.avatarUrl,
    required this.rating,
    required this.ridesCount,
    required this.kycVerified,
  });

  @override
  List<Object?> get props =>
      [id, name, email, avatarUrl, rating, ridesCount, kycVerified];
}
