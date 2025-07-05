// features/profile/data/models/profile_model.dart
import '../../domain/entities/profile.dart';

class ProfileModel extends Profile {
  ProfileModel({
    required String id,
    required String name,
    required String email,
    required String avatarUrl,
    required double rating,
    required int ridesCount,
    required bool kycVerified,
  }) : super(
          id: id,
          name: name,
          email: email,
          avatarUrl: avatarUrl,
          rating: rating,
          ridesCount: ridesCount,
          kycVerified: kycVerified,
        );

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    // 1) Extract the simple data block
    final data = json['data'];
    if (data is! Map<String, dynamic>) {
      throw FormatException(
        'ProfileModel: "data" is not a Map (${data.runtimeType})',
      );
    }

    // 2) Extract the customer_data block for avatar etc.
    final cust = json['customer_data'];
    if (cust is! Map<String, dynamic>) {
      throw FormatException(
        'ProfileModel: "customer_data" is not a Map (${cust.runtimeType})',
      );
    }

    final first = data['first_name'] as String? ?? '';
    final last  = data['last_name']  as String? ?? '';
    final email = data['email']      as String? ?? '';
    final avatar = cust['photo']     as String? ?? '';

    return ProfileModel(
      id: cust['Phone']?.toString() ?? '',  // or some stable ID if provided
      name: '$first $last'.trim(),
      email: email,
      avatarUrl: avatar,
      // You can hard‑code rating/rideCount/KYC or adjust to real fields if available:
      rating: 4.3,
      ridesCount: 2211,
      kycVerified: true,
    );
  }
}
