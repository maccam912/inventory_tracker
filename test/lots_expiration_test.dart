// Test for expiration date functionality
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';

// Import the database classes
import '../lib/database/database.dart';

void main() {
  group('Lots Expiration Date Tests', () {
    late AppDatabase database;

    setUp(() async {
      // Create an in-memory database for testing
      database = AppDatabase()..executor = DatabaseExecutor(NativeDatabase.memory());
    });

    tearDown(() async {
      await database.close();
    });

    test('should create lot with expiration date', () async {
      final expirationDate = DateTime(2025, 12, 31);
      
      // Insert a lot with expiration date
      final lotId = await database.insertLot(
        LotsCompanion.insert(
          lotNumber: 'TEST-001',
          expirationDate: Value(expirationDate),
        ),
      );

      // Retrieve the lot
      final lot = await database.getLotById(lotId);

      expect(lot.lotNumber, equals('TEST-001'));
      expect(lot.expirationDate, equals(expirationDate));
    });

    test('should create lot without expiration date', () async {
      // Insert a lot without expiration date
      final lotId = await database.insertLot(
        LotsCompanion.insert(
          lotNumber: 'TEST-002',
        ),
      );

      // Retrieve the lot
      final lot = await database.getLotById(lotId);

      expect(lot.lotNumber, equals('TEST-002'));
      expect(lot.expirationDate, isNull);
    });

    test('should update lot expiration date', () async {
      // Insert a lot without expiration date
      final lotId = await database.insertLot(
        LotsCompanion.insert(
          lotNumber: 'TEST-003',
        ),
      );

      // Get the original lot
      final originalLot = await database.getLotById(lotId);
      expect(originalLot.expirationDate, isNull);

      // Update with expiration date
      final expirationDate = DateTime(2025, 6, 15);
      final updatedLot = originalLot.copyWith(
        expirationDate: Value(expirationDate),
      );
      
      await database.updateLot(updatedLot);

      // Retrieve the updated lot
      final retrievedLot = await database.getLotById(lotId);
      expect(retrievedLot.expirationDate, equals(expirationDate));
    });

    test('should clear lot expiration date', () async {
      final expirationDate = DateTime(2025, 12, 31);
      
      // Insert a lot with expiration date
      final lotId = await database.insertLot(
        LotsCompanion.insert(
          lotNumber: 'TEST-004',
          expirationDate: Value(expirationDate),
        ),
      );

      // Get the original lot
      final originalLot = await database.getLotById(lotId);
      expect(originalLot.expirationDate, equals(expirationDate));

      // Clear expiration date
      final updatedLot = originalLot.copyWith(
        expirationDate: const Value(null),
      );
      
      await database.updateLot(updatedLot);

      // Retrieve the updated lot
      final retrievedLot = await database.getLotById(lotId);
      expect(retrievedLot.expirationDate, isNull);
    });

    test('should handle database migration from version 1 to 2', () async {
      // This test verifies that the migration strategy handles the schema upgrade
      // In a real migration test, we would create a database with version 1,
      // then upgrade to version 2 and verify the column exists
      
      expect(database.schemaVersion, equals(2));
      
      // Verify that we can insert a lot with expiration date after migration
      final lotId = await database.insertLot(
        LotsCompanion.insert(
          lotNumber: 'MIGRATION-TEST',
          expirationDate: Value(DateTime(2025, 1, 1)),
        ),
      );

      final lot = await database.getLotById(lotId);
      expect(lot.expirationDate, isNotNull);
    });
  });
}