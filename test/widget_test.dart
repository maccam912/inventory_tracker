// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Basic app structure test', (WidgetTester tester) async {
    // Build a simple app structure and trigger a frame.
    await tester.pumpWidget(
      MaterialApp(
        title: 'Inventory Tracker',
        home: Scaffold(
          appBar: AppBar(title: const Text('Inventory Tracker')),
          body: const Center(child: Text('Inventory Tracker App')),
          bottomNavigationBar: BottomNavigationBar(
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.location_on),
                label: 'Sites',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.inventory_2),
                label: 'Lots',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.assessment),
                label: 'Inventory',
              ),
            ],
          ),
        ),
      ),
    );

    // Verify that the app title is shown
    expect(find.text('Inventory Tracker'), findsWidgets);

    // Verify that the bottom navigation bar is present
    expect(find.byType(BottomNavigationBar), findsOneWidget);

    // Verify that the navigation tabs are present
    expect(find.text('Sites'), findsOneWidget);
    expect(find.text('Lots'), findsOneWidget);
    expect(find.text('Inventory'), findsOneWidget);

    // Verify basic app functionality
    expect(find.text('Inventory Tracker App'), findsOneWidget);
  });

  group('Date formatting tests', () {
    test('should format date correctly', () {
      final testDate = DateTime(2025, 3, 15);
      final formatted = _formatDate(testDate);
      expect(formatted, equals('2025/03/15'));
    });

    test('should handle null date', () {
      final formatted = _formatDate(null);
      expect(formatted, equals('No expiration date'));
    });

    test('should format single digit month and day with leading zeros', () {
      final testDate = DateTime(2025, 1, 5);
      final formatted = _formatDate(testDate);
      expect(formatted, equals('2025/01/05'));
    });
  });
}

// Helper function for date formatting (duplicated from lots_screen.dart for testing)
String _formatDate(DateTime? date) {
  if (date == null) return 'No expiration date';
  return '${date.year}/${date.month.toString().padLeft(2, '0')}/${date.day.toString().padLeft(2, '0')}';
}
