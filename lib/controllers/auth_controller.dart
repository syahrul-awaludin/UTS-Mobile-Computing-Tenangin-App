import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import '../services/auth_service.dart';
import '../views/main_tab/main_tab_view.dart';
import 'profile_controller.dart';
import 'community_controller.dart';
import 'notification_controller.dart';

class AuthController extends ChangeNotifier {
  final AuthService _authService;

  AuthController(this._authService);

  bool _obscurePassword = true;
  bool _rememberMe = false;
  bool _isLoading = false;
  Map<String, dynamic>? _userProfile;

  bool get obscurePassword => _obscurePassword;
  bool get rememberMe => _rememberMe;
  bool get isLoading => _isLoading;
  Map<String, dynamic>? get userProfile => _userProfile;

  final TextEditingController loginEmailController = TextEditingController();
  final TextEditingController loginPasswordController = TextEditingController();

  final TextEditingController registerNameController = TextEditingController();
  final TextEditingController registerEmailController = TextEditingController();
  final TextEditingController registerPasswordController = TextEditingController();

  void togglePasswordVisibility() {
    _obscurePassword = !_obscurePassword;
    notifyListeners();
  }

  void toggleRememberMe(bool? value) {
    _rememberMe = value ?? false;
    notifyListeners();
  }

  Future<void> login(BuildContext context) async {
    final email = loginEmailController.text.trim();
    final password = loginPasswordController.text;

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in both email and password')),
      );
      return;
    }

    _isLoading = true;
    notifyListeners();

    try {
      final data = await _authService.login(email, password);
      final token = data['accessToken'] ?? data['token'];
      final refreshToken = data['refreshToken'];
      
      final prefs = await SharedPreferences.getInstance();
      if (token != null) {
        await prefs.setString('auth_token', token);
      }
      if (refreshToken != null) {
        await prefs.setString('refresh_token', refreshToken);
      }
      await prefs.setBool('is_logged_in', true);

      await fetchUserProfile();

      if (context.mounted) {
        // Provide fresh data for the newly logged in user
        context.read<ProfileController>().fetchProfile();
        context.read<CommunityController>().fetchPosts();
        context.read<NotificationController>().loadNotifications();
        
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const MainTabView()),
        );
      }
    } catch (e) {
      if (context.mounted) {
        // Strip the "Exception: " prefix if it exists to make it look cleaner
        final errorMessage = e.toString().replaceFirst('Exception: ', '');
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(errorMessage)));
      }
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> register(BuildContext context) async {
    final name = registerNameController.text.trim();
    final email = registerEmailController.text.trim();
    final password = registerPasswordController.text;

    if (name.isEmpty || email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all fields')),
      );
      return;
    }

    _isLoading = true;
    notifyListeners();

    try {
      await _authService.register(name, email, password);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Registration successful! Please login.')),
        );
        Navigator.pop(context);
      }
    } catch (e) {
      if (context.mounted) {
        final errorMessage = e.toString().replaceFirst('Exception: ', '');
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(errorMessage)));
      }
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> logout(VoidCallback onLogout) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_token');
    await prefs.remove('refresh_token');
    await prefs.setBool('is_logged_in', false);
    onLogout();
  }

  Future<bool> checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final isLoggedIn = prefs.getBool('is_logged_in') ?? false;
    if (isLoggedIn) {
      await fetchUserProfile();
    }
    return isLoggedIn;
  }

  Future<void> fetchUserProfile() async {
    _isLoading = true;
    notifyListeners();

    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('auth_token');
      if (token != null) {
        _userProfile = await _authService.getMe();
      }
    } catch (e) {
      debugPrint('Failed to fetch user profile: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    loginEmailController.dispose();
    loginPasswordController.dispose();
    registerNameController.dispose();
    registerEmailController.dispose();
    registerPasswordController.dispose();
    super.dispose();
  }
}
