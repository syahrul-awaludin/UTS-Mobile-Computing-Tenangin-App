import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controllers/auth_controller.dart';
import '../../theme/app_colors.dart';
import '../../widgets/auth/auth_input_field.dart';
import '../../widgets/common/app_primary_button.dart';
import '../../widgets/common/social_login_button.dart';


class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppColors.primaryDeep,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header Graphic
            Container(
              width: double.infinity,
              color: AppColors.primaryDeep,
              child: Image.asset(
                'assets/images/Sign_In.png',
                fit: BoxFit.fitWidth,
                alignment: Alignment.bottomCenter,
              ),
            ),

            // White Content Container
            Transform.translate(
              offset: const Offset(0, -1),
              child: Container(
                width: double.infinity,
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Consumer<AuthController>(
                    builder: (context, authController, _) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Create Account',
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w700,
                              color: AppColors.textHeading,
                              fontFamily: 'Inter',
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Sign up to get started with Tenangin.',
                            style: TextStyle(
                              fontSize: 14,
                              color: AppColors.textCaption,
                            ),
                          ),
                          const SizedBox(height: 32),

                          // Name Input
                          AuthInputField(
                            controller: authController.registerNameController,
                            icon: Icons.person_outline,
                            hint: 'Full Name',
                            obscure: false,
                          ),
                          const SizedBox(height: 16),

                          // Email Input
                          AuthInputField(
                            controller: authController.registerEmailController,
                            icon: Icons.email_outlined,
                            hint: 'Email Address',
                            obscure: false,
                          ),
                          const SizedBox(height: 16),

                          // Password Input
                          AuthInputField(
                            controller: authController.registerPasswordController,
                            icon: Icons.lock_outline,
                            hint: 'Password',
                            obscure: authController.obscurePassword,
                            trailing: GestureDetector(
                              onTap: authController.togglePasswordVisibility,
                              child: Icon(
                                authController.obscurePassword
                                    ? Icons.visibility_off_outlined
                                    : Icons.visibility_outlined,
                                color: AppColors.textCaption,
                              ),
                            ),
                          ),
                          const SizedBox(height: 32),

                          // Sign Up Button
                          authController.isLoading 
                            ? const Center(child: CircularProgressIndicator(color: AppColors.primary))
                            : AppPrimaryButton(
                            label: 'Sign Up',
                            onPressed: () => authController.register(context),
                          ),
                          const SizedBox(height: 48),

                          // Or sign in with divider
                          Row(
                            children: [
                              Expanded(
                                  child: Divider(
                                      color: AppColors.borderDefault)),
                              const Padding(
                                padding:
                                    EdgeInsets.symmetric(horizontal: 16),
                                child: Text(
                                  'Or sign up with',
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: AppColors.textCaption,
                                  ),
                                ),
                              ),
                              Expanded(
                                  child: Divider(
                                      color: AppColors.borderDefault)),
                            ],
                          ),
                          const SizedBox(height: 24),

                          // Social Buttons
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SocialLoginButton(
                                  assetPath: 'assets/icons/google.svg'),
                              const SizedBox(width: 16),
                              SocialLoginButton(
                                  assetPath: 'assets/icons/apple.svg'),
                              const SizedBox(width: 16),
                              SocialLoginButton(
                                  assetPath: 'assets/icons/facebook.svg'),
                            ],
                          ),
                          const SizedBox(height: 48),

                          // Sign In link
                          Center(
                            child: Wrap(
                              alignment: WrapAlignment.center,
                              crossAxisAlignment: WrapCrossAlignment.center,
                              children: [
                                const Text(
                                  "Already have an account? ",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: AppColors.textHeading,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text(
                                    'Sign In',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.primary,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 24),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

}
