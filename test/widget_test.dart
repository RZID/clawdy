import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:clawdy/main.dart';
import 'package:clawdy/core/controllers/app_controller.dart';

void main() {
  testWidgets('App Welcome Screen Render Test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => AppController(),
        child: const MyApp(),
      ),
    );

    // Verify that "Welcome back." title exists
    expect(find.text('Welcome back.'), findsOneWidget);
    
    // Verify that Clawdy. logo text exists
    expect(find.text('Clawdy.'), findsOneWidget);

    // Verify that the continue button exists
    expect(find.text('Continue'), findsOneWidget);
  });
}
