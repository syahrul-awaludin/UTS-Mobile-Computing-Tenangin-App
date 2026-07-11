import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:tenangin_app/views/main_tab/main_tab_view.dart';
import 'package:tenangin_app/services/socket_service.dart';
import 'package:tenangin_app/services/learn_service.dart';
import 'package:tenangin_app/controllers/learn_controller.dart';
import 'package:tenangin_app/services/community_service.dart';
import 'package:tenangin_app/controllers/community_controller.dart';
import 'package:tenangin_app/services/auth_service.dart';
import 'package:tenangin_app/controllers/auth_controller.dart';
import 'package:tenangin_app/services/home_service.dart';
import 'package:tenangin_app/controllers/home_controller.dart';
import 'package:tenangin_app/services/profile_service.dart';
import 'package:tenangin_app/controllers/profile_controller.dart';

void main() {
  testWidgets('Test Search Bar interaction', (WidgetTester tester) async {
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          Provider(create: (_) => AuthService()),
          Provider(create: (_) => HomeService()),
          Provider(create: (_) => LearnService()),
          Provider(create: (_) => CommunityService()),
          Provider(create: (_) => ProfileService()),
          ChangeNotifierProvider(create: (_) => SocketService()),
          ChangeNotifierProxyProvider<AuthService, AuthController>(
            create: (context) => AuthController(context.read<AuthService>()),
            update: (_, service, prev) => prev ?? AuthController(service),
          ),
          ChangeNotifierProxyProvider<HomeService, HomeController>(
            create: (context) => HomeController(context.read<HomeService>()),
            update: (_, service, prev) => prev ?? HomeController(service),
          ),
          ChangeNotifierProxyProvider<LearnService, LearnController>(
            create: (context) => LearnController(context.read<LearnService>()),
            update: (_, service, prev) => prev ?? LearnController(service),
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
            update: (_, cService, sService, prev) =>
                prev ?? CommunityController(cService, sService),
          ),
          ChangeNotifierProxyProvider<ProfileService, ProfileController>(
            create: (context) =>
                ProfileController(context.read<ProfileService>()),
            update: (_, service, prev) => prev ?? ProfileController(service),
          ),
        ],
        child: const MaterialApp(home: MainTabView()),
      ),
    );

    // Initial pump and wait for things to settle
    await tester.pumpAndSettle();

    // Tap on the Learn tab
    await tester.tap(find.text('Learn'));
    await tester.pumpAndSettle();

    // Find SearchBar
    final searchBar = find.byType(SearchBar);
    expect(searchBar, findsOneWidget);

    // Tap SearchBar
    await tester.tap(searchBar);
    await tester.pump();

    // Enter text
    await tester.enterText(searchBar, 'hello');
    await tester.pumpAndSettle();

    // Check if text is entered
    final textFinder = find.text('hello');
    expect(textFinder, findsOneWidget);
    // print('SEARCH BAR TEST PASSED: TEXT WAS ENTERED');
  });
}
