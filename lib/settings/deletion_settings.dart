import 'package:flutter/material.dart';

class DeletionSettings extends ChangeNotifier {
  // The deletion toggle. Default is false (disabled).
  bool _isDeletionEnabled = false;

  // Getter for the deletion enabled state
  bool get isDeletionEnabled => _isDeletionEnabled;

  // Toggle the deletion enabled state
  void toggleDeletion(bool value) {
    _isDeletionEnabled = value;
    notifyListeners();
  }
}

class DeletionSettingsProvider extends InheritedNotifier<DeletionSettings> {
  const DeletionSettingsProvider({
    super.key,
    required DeletionSettings settings,
    required super.child,
  }) : super(notifier: settings);

  // Helper to access the settings from anywhere in the widget tree
  static DeletionSettings of(BuildContext context) {
    final provider = context
        .dependOnInheritedWidgetOfExactType<DeletionSettingsProvider>();
    if (provider == null) {
      throw Exception('No DeletionSettingsProvider found in context');
    }
    return provider.notifier!;
  }
}
