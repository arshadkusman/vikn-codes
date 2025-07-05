import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../core/utils/styles.dart';
import '../bloc/auth_cubit.dart';
import '../bloc/auth_state.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _usernameCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  bool _obscure = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      // extend body behind status bar
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          // 1. Background gradient
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF000000),
                  Color.fromARGB(255, 40, 40, 16),
                  Color.fromARGB(255, 45, 7, 30),
                ],
              ),
            ),
          ),

          // 2. Main content
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Language selector top‑right
                  Align(
                    alignment: Alignment.topRight,
                    child: TextButton.icon(
                      onPressed: () {
                        // TODO: switch language
                      },
                      icon: Icon(
                        Iconsax.translate5,
                        color: Color(0xff0E75F4),
                        size: 18,
                      ),
                      label: Text(
                        'English',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),

                  Spacer(flex: 2),

                  // Title / subtitle
                  Text(
                    'Login',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Login to your vikn account',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                  ),

                  SizedBox(height: 32),

                  // Input card
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.black12,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        // Username
                        TextField(
                          controller: _usernameCtrl,
                          style: TextStyle(color: Colors.white),
                          decoration: Styles.inputDecoration.copyWith(
                            hintText: 'Username',
                            hintStyle: TextStyle(color: Colors.white54),
                            prefixIcon: Icon(
                              Iconsax.user,
                              color: Color(0xff0A9EF3),
                            ),
                          ),
                        ),
                        SizedBox(height: 16),

                        // Password
                        TextField(
                          controller: _passwordCtrl,
                          obscureText: _obscure,
                          style: TextStyle(color: Colors.white),
                          decoration: Styles.inputDecoration.copyWith(
                            hintText: 'Password',
                            hintStyle: TextStyle(color: Colors.white54),
                            prefixIcon: Icon(
                              Iconsax.key,
                              color: Color(0xff0A9EF3),
                            ),
                            suffixIcon: GestureDetector(
                              onTap: () => setState(() => _obscure = !_obscure),
                              child: Icon(
                                _obscure ? Iconsax.eye_slash : Iconsax.eye,
                                color: Color(0xff0A9EF3),
                                size: 24,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 16),

                  // Forgotten Password?
                  Align(
                    alignment: Alignment.center,
                    child: TextButton(
                      onPressed: () {
                        // TODO: navigate to password reset
                      },
                      child: Text(
                        'Forgotten Password?',
                        style: TextStyle(color: Color(0xff0A9EF3)),
                      ),
                    ),
                  ),

                  SizedBox(height: 16),

                  // Sign In button
                  BlocConsumer<AuthCubit, AuthState>(
                    listener: (context, state) {
                      if (state is AuthFailure) {
                        ScaffoldMessenger.of(
                          context,
                        ).showSnackBar(SnackBar(content: Text(state.message)));
                      } else if (state is AuthSuccess) {
                        Navigator.pushReplacementNamed(context, '/');
                      }
                    },
                    builder: (context, state) {
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 120),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xff0E75F4),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 14),
                          ),
                          onPressed:
                              state is AuthLoading
                                  ? null
                                  : () {
                                    context.read<AuthCubit>().login(
                                      username: _usernameCtrl.text.trim(),
                                      password: _passwordCtrl.text.trim(),
                                    );
                                  },
                          child:
                              state is AuthLoading
                                  ? SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      valueColor: AlwaysStoppedAnimation(
                                        Colors.white,
                                      ),
                                    ),
                                  )
                                  : Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Sign in',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.white,
                                        ),
                                      ),
                                      SizedBox(width: 8),
                                      Icon(
                                        Icons.arrow_forward,
                                        size: 20,
                                        color: Colors.white,
                                      ),
                                    ],
                                  ),
                        ),
                      );
                    },
                  ),

                  Spacer(flex: 3),

                  // Sign up prompt
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an Account?",
                        style: TextStyle(color: Colors.white70),
                      ),
                      TextButton(
                        onPressed: () {
                          // TODO: navigate to signup
                        },
                        child: Text(
                          'Sign up now!',
                          style: TextStyle(color: Color(0xff0A9EF3)),
                        ),
                      ),
                      SizedBox(height: 10),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
