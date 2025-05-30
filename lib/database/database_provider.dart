import 'package:flutter/material.dart';
import 'database.dart';

class DatabaseProvider extends InheritedWidget {
  final AppDatabase database;

  const DatabaseProvider({
    super.key,
    required this.database,
    required super.child,
  });

  static AppDatabase of(BuildContext context) {
    final provider = context
        .dependOnInheritedWidgetOfExactType<DatabaseProvider>();
    return provider!.database;
  }

  @override
  bool updateShouldNotify(DatabaseProvider oldWidget) => false;
}
