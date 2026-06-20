import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:crest/main.dart';

// End-to-end smoke test: boots the full app with mocked platform plugins
// (SharedPreferences + an in-memory SQLite database) and verifies the main
// navigation scaffold renders without throwing.

void main() {
  setUpAll(() {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  });

  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  testWidgets('App boots and shows the main navigation', (tester) async {
    await tester.pumpWidget(const CrestApp());
    await tester.pumpAndSettle();

    // The default tab is "Today"; the bottom navigation should be present.
    expect(find.byType(NavigationBar), findsOneWidget);
    expect(find.text('Today'), findsWidgets);
  });
}
