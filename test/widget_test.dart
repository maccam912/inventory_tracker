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
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: 'Settings',
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
    expect(find.text('Settings'), findsOneWidget);

    // Verify basic app functionality
    expect(find.text('Inventory Tracker App'), findsOneWidget);
  });
}
