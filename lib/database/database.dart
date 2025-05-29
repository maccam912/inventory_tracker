import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

// Tables
part 'database.g.dart';

class Sites extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get siteName => text().withLength(min: 1, max: 100)();
}

class Lots extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get lotNumber => text().withLength(min: 1, max: 50)();
}

class InventorySnapshots extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get siteId => integer().references(Sites, #id)();
  IntColumn get lotId => integer().references(Lots, #id)();
  IntColumn get count => integer()();
  DateTimeColumn get timestamp =>
      dateTime().withDefault(Constant(DateTime.now()))();
}

@DriftDatabase(tables: [Sites, Lots, InventorySnapshots])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) async {
        await m.createAll();
      },
      onUpgrade: (Migrator m, int from, int to) async {
        // Add future migrations here
      },
    );
  }

  // Close the database
  @override
  Future<void> close() => executor.close();

  // Site operations
  Future<List<Site>> getAllSites() => select(sites).get();
  Future<Site> getSiteById(int id) =>
      (select(sites)..where((s) => s.id.equals(id))).getSingle();
  Future<int> insertSite(SitesCompanion site) => into(sites).insert(site);
  Future<bool> updateSite(Site site) => update(sites).replace(site);
  Future<int> deleteSite(int id) =>
      (delete(sites)..where((s) => s.id.equals(id))).go();

  // Lot operations
  Future<List<Lot>> getAllLots() => select(lots).get();
  Future<Lot> getLotById(int id) =>
      (select(lots)..where((l) => l.id.equals(id))).getSingle();
  Future<int> insertLot(LotsCompanion lot) => into(lots).insert(lot);
  Future<bool> updateLot(Lot lot) => update(lots).replace(lot);
  Future<int> deleteLot(int id) =>
      (delete(lots)..where((l) => l.id.equals(id))).go();

  // Inventory Snapshot operations
  Future<List<InventorySnapshot>> getAllInventorySnapshots() =>
      select(inventorySnapshots).get();

  Future<List<InventorySnapshotWithDetails>>
  getAllInventorySnapshotsWithDetails() {
    final query = select(inventorySnapshots).join([
      innerJoin(sites, sites.id.equalsExp(inventorySnapshots.siteId)),
      innerJoin(lots, lots.id.equalsExp(inventorySnapshots.lotId)),
    ]);

    return query.map((row) {
      final snapshot = row.readTable(inventorySnapshots);
      final site = row.readTable(sites);
      final lot = row.readTable(lots);

      return InventorySnapshotWithDetails(
        snapshot: snapshot,
        site: site,
        lot: lot,
      );
    }).get();
  }

  Future<int> insertInventorySnapshot(InventorySnapshotsCompanion snapshot) =>
      into(inventorySnapshots).insert(snapshot);

  Future<bool> updateInventorySnapshot(InventorySnapshot snapshot) =>
      update(inventorySnapshots).replace(snapshot);

  Future<int> deleteInventorySnapshot(int id) =>
      (delete(inventorySnapshots)..where((s) => s.id.equals(id))).go();
}

// Custom class to hold joined data
class InventorySnapshotWithDetails {
  final InventorySnapshot snapshot;
  final Site site;
  final Lot lot;

  InventorySnapshotWithDetails({
    required this.snapshot,
    required this.site,
    required this.lot,
  });
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'inventory.sqlite'));
    return NativeDatabase(file);
  });
}
