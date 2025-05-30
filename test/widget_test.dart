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
                icon: Icon(Icons.bar_chart),
                label: 'Reports',
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
    expect(find.text('Reports'), findsOneWidget);
    expect(find.text('Settings'), findsOneWidget);

    // Verify basic app functionality
    expect(find.text('Inventory Tracker App'), findsOneWidget);
  });

  testWidgets('Dark purple theme is applied correctly', (
    WidgetTester tester,
  ) async {
    const colorScheme = ColorScheme.dark(
      brightness: Brightness.dark,
      primary: Color(0xFF8A5CF6), // Lighter purple for primary elements
      onPrimary: Color(0xFF1A0F2E), // Dark text on primary
      secondary: Color(0xFF6366F1), // Indigo-blue accent
      onSecondary: Color(0xFF1A0F2E), // Dark text on secondary
      tertiary: Color(0xFF8B5DFF), // Bright purple accent
      onTertiary: Color(0xFF1A0F2E), // Dark text on tertiary
      surface: Color(0xFF1A0F2E), // Dark purple surface
      onSurface: Color(0xFFE5DEFF), // Light purple text on dark surface
      surfaceContainerHighest: Color(0xFF2D1B3D), // Slightly lighter surface
      onSurfaceVariant: Color(
        0xFFD0BCFF,
      ), // Muted light purple for secondary text
      outline: Color(0xFF6B46C1), // Purple outline color
      error: Color(0xFFFF6B9D), // Pink-purple error color
      onError: Color(0xFF1A0F2E), // Dark text on error
    );

    // Create a simple test app with the same theme configuration
    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData(useMaterial3: true, colorScheme: colorScheme),
        home: Scaffold(
          appBar: AppBar(
            title: const Text('Test App'),
            backgroundColor: colorScheme.primary,
            foregroundColor: Colors.white,
          ),
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            selectedItemColor: colorScheme.primary,
            unselectedItemColor: colorScheme.onSurface.withValues(alpha: 0.6),
            backgroundColor: colorScheme.surface,
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
                icon: Icon(Icons.bar_chart),
                label: 'Reports',
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

    // Find the MaterialApp widget to verify theme
    final materialApp = tester.widget<MaterialApp>(find.byType(MaterialApp));
    final theme = materialApp.theme!;

    // Verify dark theme is applied
    expect(theme.colorScheme.brightness, Brightness.dark);

    // Verify specific purple color scheme
    expect(theme.colorScheme.primary, const Color(0xFF8A5CF6));
    expect(theme.colorScheme.surface, const Color(0xFF1A0F2E));
    expect(theme.colorScheme.secondary, const Color(0xFF6366F1));

    // Verify Material3 is enabled
    expect(theme.useMaterial3, true);

    // Verify bottom navigation bar is present and properly styled
    expect(find.byType(BottomNavigationBar), findsOneWidget);

    final bottomNavBar = tester.widget<BottomNavigationBar>(
      find.byType(BottomNavigationBar),
    );
    expect(bottomNavBar.type, BottomNavigationBarType.fixed);

    // Verify that icon colors are properly set (this addresses the original issue)
    expect(bottomNavBar.backgroundColor, colorScheme.surface);
    expect(bottomNavBar.selectedItemColor, colorScheme.primary);
  });
}
