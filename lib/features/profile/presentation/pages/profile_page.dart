// features/profile/presentation/pages/profile_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../core/utils/styles.dart';
import '../../domain/entities/profile.dart';
import '../bloc/profile_cubit.dart';
import '../bloc/profile_state.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Kick off the load exactly once when this widget builds:
    context.read<ProfileCubit>().loadProfile();

    return Scaffold(
      backgroundColor: Color(0xFF000000),
      body: SafeArea(
        child: BlocBuilder<ProfileCubit, ProfileState>(
          builder: (context, state) {
            if (state is ProfileLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ProfileLoaded) {
              return _ProfileView(profile: state.profile);
            } else if (state is ProfileFailure) {
              return Center(
                child: Text(
                  state.message,
                  style: TextStyle(color: Colors.white),
                ),
              );
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}

class _ProfileView extends StatelessWidget {
  final Profile profile;
  const _ProfileView({required this.profile});

  @override
  Widget build(BuildContext context) {
    const cardColor = Color(0xFFFFFFFF);
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // Top profile card
        Container(
          decoration: BoxDecoration(
            color: cardColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(32),
          ),
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // Avatar, name, email, edit icon
              Row(
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(32),
                      color: Colors.black,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Image.asset(
                        'assets/images/avatar.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          profile.name,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          profile.email,
                          style: TextStyle(
                            color: Color(0xffB5CDFE),
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: Icon(Iconsax.edit, color: Colors.white),
                    onPressed: () {
                      // TODO: navigate to edit profile
                    },
                  ),
                ],
              ),

              SizedBox(height: 16),

              // Rating & KYC pills
              Row(
                children: [
                  Expanded(
                    child: _StatsCard(
                      icon: Icons.star,
                      iconBg: Color(0xFF42A5F5).withOpacity(0.15),
                      title: '${profile.rating.toStringAsFixed(1)}★',
                      value: '${profile.ridesCount}',
                      subtitle: 'Rides',
                      accent: Color(0xFF42A5F5),
                    ),
                  ),
                  SizedBox(width: 14),
                  Expanded(
                    child: _StatsCard(
                      icon: Icons.verified_user,
                      iconBg: (profile.kycVerified
                              ? Colors.greenAccent
                              : Colors.orangeAccent)
                          .withOpacity(0.15),
                      title: 'KYC',
                      value: profile.kycVerified ? 'Verified' : 'Pending',
                      subtitle: profile.kycVerified ? 'KYC✓' : 'KYC✗',
                      accent:
                          profile.kycVerified
                              ? Colors.greenAccent
                              : Colors.orangeAccent,
                    ),
                  ),
                ],
              ),

              SizedBox(height: 16),

              // Logout button
              SizedBox(
                width: double.infinity,
                child: TextButton.icon(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.black,
                    padding: EdgeInsets.all(16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32),
                    ),
                  ),
                  onPressed: () {
                    context.read<ProfileCubit>().logout();
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      '/login',
                      (_) => false,
                    );
                  },
                  icon: Icon(Iconsax.logout, color: Colors.redAccent),
                  label: Text(
                    'Logout',
                    style: TextStyle(color: Colors.redAccent),
                  ),
                ),
              ),
            ],
          ),
        ),

        SizedBox(height: 24),

        // Menu items
        Column(
          spacing: 14,
          children: [
            _MenuItem(icon: Icons.help_outline, title: 'Help', onTap: () {}),
            _MenuItem(
              icon: Iconsax.message_question,
              title: 'FAQ',
              onTap: () {},
            ),
            _MenuItem(
              icon: Iconsax.profile_add,
              title: 'Invite Friends',
              onTap: () {},
            ),
            _MenuItem(
              icon: Iconsax.shield_search,
              title: 'Terms of service',
              onTap: () {},
            ),
            _MenuItem(
              icon: Iconsax.security,
              title: 'Privacy Policy',
              onTap: () {},
            ),
          ],
        ),
      ],
    );
  }
}

/// A vertically‑oriented pill showing an icon, a main label and a sublabel.

/// A simple list tile with an icon, title, and trailing arrow.
class _MenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const _MenuItem({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 10,
      children: [
        ListTile(
          leading: Icon(icon, color: Color(0xffB5CDFE)),
          title: Text(title, style: TextStyle(color: Colors.white)),
          trailing: Icon(Icons.arrow_forward_ios, color: Colors.white54),
          onTap: onTap,
        ),
      ],
    );
  }
}

class _StatsCard extends StatelessWidget {
  final IconData icon;
  final Color iconBg;
  final String title;
  final String value;
  final String subtitle;
  final Color accent;

  const _StatsCard({
    required this.icon,
    required this.iconBg,
    required this.title,
    required this.value,
    required this.subtitle,
    required this.accent,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xff000000),
        borderRadius: BorderRadius.circular(32),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          // Icon pill
          Container(
            height: 80,
            decoration: BoxDecoration(
              color: iconBg,
              borderRadius: BorderRadius.circular(32),
            ),
            padding: const EdgeInsets.all(8),
            child: Icon(icon, color: accent),
          ),

          SizedBox(width: 16),

          // Text
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: TextStyle(color: Colors.white, fontSize: 14)),
              Text(
                value,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                subtitle,
                style: TextStyle(color: Colors.white54, fontSize: 12),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
