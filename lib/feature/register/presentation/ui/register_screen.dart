import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gamezone/core/routes/app_routes.dart';
import 'package:gamezone/core/theme/app_colors.dart';
import 'package:gamezone/core/widgets/app_button.dart';
import 'package:gamezone/core/widgets/custom_text_field.dart';
import 'package:gamezone/feature/register/presentation/cubit/register_state.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../data/models/register_request_model.dart';
import '../cubit/register_cubit.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Color(0xFF09090F)),
      backgroundColor: AppColors.black,
      body: BlocConsumer<RegisterCubit, RegisterState>(
        listener: (context, state) {
          if (state.status == Status.success) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Registration successful'),
                backgroundColor: Colors.green,
              ),
            );
            // Navigate to login after success
            Navigator.pushReplacementNamed(context, AppRoutes.login);
          } else if (state.status == Status.error) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Registration failed'),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Join GameZone",
                      style: GoogleFonts.oxanium(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: AppColors.white,
                      ),
                    ),
                    Text(
                      "Create your account and start gaming",
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: AppColors.lightPurple,
                      ),
                    ),
                    SizedBox(height: 30),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Username",
                          style: GoogleFonts.oxanium(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: AppColors.lightPurple,
                          ),
                        ),
                        SizedBox(height: 10),
                        CustomTextField(
                          hint: "Pick a cool username",
                          controller: _nameController,
                          keyboardType: TextInputType.text,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Please enter your name';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),

                    SizedBox(height: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Email Address",
                          style: GoogleFonts.oxanium(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: AppColors.lightPurple,
                          ),
                        ),
                        SizedBox(height: 10),
                        CustomTextField(
                          hint: "you@example.com",
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Please enter your email';
                            }
                            if (!RegExp(
                              r'^[^@]+@[^@]+\.[^@]+',
                            ).hasMatch(value)) {
                              return 'Please enter a valid email';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Password",
                          style: GoogleFonts.oxanium(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: AppColors.lightPurple,
                          ),
                        ),
                        SizedBox(height: 10),
                        CustomTextField(
                          obscureText: true,
                          hint: "Create a strong password",
                          controller: _passwordController,
                          keyboardType: TextInputType.visiblePassword,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password';
                            }
                            if (value.length < 6) {
                              return 'Password must be at least 6 characters';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 30),
                    AppButton(
                      text: "Create Account",
                      onPressed: _createAccount,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _createAccount() {
    if (_formKey.currentState!.validate()) {
      final registerModel = RegisterRequestModel(
        username: _nameController.text.trim(),
        email: _emailController.text.trim(),
        password: _passwordController.text,
      );
      context.read<RegisterCubit>().register(registerModel);
    }
  }
}
