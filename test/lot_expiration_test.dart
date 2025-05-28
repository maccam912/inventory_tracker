import 'package:flutter_test/flutter_test.dart';
import 'package:drift/drift.dart';
import 'package:inventory_tracker/database/database.dart';

void main() {
  group('Lot Model Tests', () {
    test('Lot can be created with expiration date', () {
      final expirationDate = DateTime(2025, 12, 31);
      
      final lot = Lot(
        id: 1,
        lotNumber: 'TEST-001',
        expirationDate: expirationDate,
      );

      expect(lot.id, 1);
      expect(lot.lotNumber, 'TEST-001');
      expect(lot.expirationDate, expirationDate);
    });

    test('Lot can be created without expiration date', () {
      final lot = Lot(
        id: 2,
        lotNumber: 'TEST-002',
        expirationDate: null,
      );

      expect(lot.id, 2);
      expect(lot.lotNumber, 'TEST-002');
      expect(lot.expirationDate, null);
    });

    test('LotsCompanion can include expiration date', () {
      final expirationDate = DateTime(2025, 6, 15);
      
      final companion = LotsCompanion.insert(
        lotNumber: 'TEST-003',
        expirationDate: Value(expirationDate),
      );

      expect(companion.lotNumber.value, 'TEST-003');
      expect(companion.expirationDate.value, expirationDate);
    });

    test('LotsCompanion can exclude expiration date', () {
      final companion = LotsCompanion.insert(
        lotNumber: 'TEST-004',
      );

      expect(companion.lotNumber.value, 'TEST-004');
      expect(companion.expirationDate, const Value.absent());
    });

    test('Lot copyWith can update expiration date', () {
      final originalLot = Lot(
        id: 3,
        lotNumber: 'TEST-005',
        expirationDate: null,
      );

      final expirationDate = DateTime(2025, 9, 30);
      final updatedLot = originalLot.copyWith(
        expirationDate: Value(expirationDate),
      );

      expect(updatedLot.id, 3);
      expect(updatedLot.lotNumber, 'TEST-005');
      expect(updatedLot.expirationDate, expirationDate);
    });

    test('Lot copyWith can clear expiration date', () {
      final originalLot = Lot(
        id: 4,
        lotNumber: 'TEST-006',
        expirationDate: DateTime(2025, 4, 15),
      );

      final updatedLot = originalLot.copyWith(
        expirationDate: const Value(null),
      );

      expect(updatedLot.id, 4);
      expect(updatedLot.lotNumber, 'TEST-006');
      expect(updatedLot.expirationDate, null);
    });
  });
}