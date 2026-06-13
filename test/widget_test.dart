import 'package:flutter_test/flutter_test.dart';
import 'package:tenangin_app/main.dart';

void main() {
  testWidgets('App loads smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const TenanginApp());

    // Wait for splash screen to disappear
    await tester.pump(const Duration(seconds: 2));
    await tester.pumpAndSettle();
    
    // Test passes if it builds without throwing exceptions
    expect(true, isTrue);
  });
}
