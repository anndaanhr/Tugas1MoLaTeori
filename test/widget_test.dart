// This is a basic Flutter widget test for the Perfume Catalog app.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:tugas1mola_2317051082/main.dart';
import 'package:tugas1mola_2317051082/pages/login_page.dart';

void main() {
  testWidgets('Perfume Catalog app loads correctly', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const PerfumeCatalogApp());

    // Verify that the app loads without errors.
    expect(find.byType(MaterialApp), findsOneWidget);

    // Verify that login page is displayed.
    expect(find.byType(LoginPage), findsOneWidget);
  });
}
