import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:overlay_support/overlay_support.dart';
import 'theme/app_theme.dart';
import 'views/splash/splash_view.dart';

// Controllers
import 'controllers/auth_controller.dart';
import 'controllers/home_controller.dart';
import 'controllers/learn_controller.dart';
import 'controllers/community_controller.dart';
import 'controllers/profile_controller.dart';
import 'controllers/notification_controller.dart';

// Services
import 'services/auth_service.dart';
import 'services/home_service.dart';
import 'services/learn_service.dart';
import 'services/community_service.dart';
import 'services/profile_service.dart';
import 'services/notification_service.dart';
import 'services/socket_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService.initialize();
  await NotificationService.requestPermission();
  runApp(const TenanginApp());
}

class TenanginApp extends StatelessWidget {
  const TenanginApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Services
        Provider(create: (_) => AuthService()),
        Provider(create: (_) => HomeService()),
        Provider(create: (_) => LearnService()),
        Provider(create: (_) => CommunityService()),
        Provider(create: (_) => ProfileService()),
        Provider(create: (_) => NotificationService()),
        ChangeNotifierProvider(create: (_) => SocketService()),

        // Controllers
        ChangeNotifierProxyProvider<AuthService, AuthController>(
          create: (context) => AuthController(context.read<AuthService>()),
          update: (context, authService, previous) =>
              previous ?? AuthController(authService),
        ),
        ChangeNotifierProxyProvider<HomeService, HomeController>(
          create: (context) => HomeController(context.read<HomeService>()),
          update: (context, homeService, previous) =>
              previous ?? HomeController(homeService),
        ),
        ChangeNotifierProxyProvider<LearnService, LearnController>(
          create: (context) => LearnController(context.read<LearnService>()),
          update: (context, learnService, previous) =>
              previous ?? LearnController(learnService),
        ),
        ChangeNotifierProxyProvider2<
          CommunityService,
          SocketService,
          CommunityController
        >(
          create: (context) => CommunityController(
            context.read<CommunityService>(),
            context.read<SocketService>(),
          ),
          update: (context, communityService, socketService, previous) =>
              previous ?? CommunityController(communityService, socketService),
        ),
        ChangeNotifierProxyProvider<ProfileService, ProfileController>(
          create: (context) =>
              ProfileController(context.read<ProfileService>()),
          update: (context, profileService, previous) =>
              previous ?? ProfileController(profileService),
        ),
        ChangeNotifierProxyProvider<
          NotificationService,
          NotificationController
        >(
          create: (context) =>
              NotificationController(context.read<NotificationService>()),
          update: (context, notificationService, previous) =>
              previous ?? NotificationController(notificationService),
        ),
      ],
      child: OverlaySupport.global(
        child: MaterialApp(
          title: 'Tenangin',
          theme: AppTheme.lightTheme,
          home: const SplashView(),
          debugShowCheckedModeBanner: false,
        ),
      ),
    );
  }
}
