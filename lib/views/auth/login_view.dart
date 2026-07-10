import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controllers/auth_controller.dart';
import '../../theme/app_colors.dart';
import '../../widgets/auth/auth_input_field.dart';
import '../../widgets/common/app_primary_button.dart';
import '../../widgets/common/social_login_button.dart';
import 'register_view.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
                            'Welcome Back!',
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w700,
                              color: AppColors.textHeading,
                              fontFamily: 'Inter',
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Sign in to continue your journey with Tenangin.',
                            style: TextStyle(
                              fontSize: 14,
                              color: AppColors.textCaption,
                            ),
                          ),
                          const SizedBox(height: 32),

                          // Email Input
                          AuthInputField(
                            controller: authController.loginEmailController,
                            icon: Icons.email_outlined,
                            hint: 'Enter your email',
                            obscure: false,
                          ),
                          const SizedBox(height: 16),

                          // Password Input
                          AuthInputField(
                            controller: authController.loginPasswordController,
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
                          const SizedBox(height: 16),

                          // Remember me & Forgot Password
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: Checkbox(
                                        value: authController.rememberMe,
                                        onChanged:
                                            authController.toggleRememberMe,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(4),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    const Flexible(
                                      child: Text(
                                        'Remember me',
                                        style: TextStyle(
                                            fontSize: 13,
                                            color: AppColors.textHeading),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const Text(
                                'Forgot Password?',
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.primary,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 32),

                          // Sign In Button
                          authController.isLoading 
                            ? const Center(child: CircularProgressIndicator(color: AppColors.primary))
                            : AppPrimaryButton(
                            label: 'Sign In',
                            onPressed: () => authController.login(context),
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
                                  'Or sign in with',
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

                          // Sign Up link
                          Center(
                            child: Wrap(
                              alignment: WrapAlignment.center,
                              crossAxisAlignment: WrapCrossAlignment.center,
                              children: [
                                const Text(
                                  "Don't have an account? ",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: AppColors.textHeading,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const RegisterView(),
                                      ),
                                    );
                                  },
                                  child: const Text(
                                    'Sign Up',
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
