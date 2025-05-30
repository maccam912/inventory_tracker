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
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();
}

class Lots extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get lotNumber => text().withLength(min: 1, max: 50)();
  DateTimeColumn get expirationDate => dateTime().nullable()();
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();
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

  // Constructor for testing
  AppDatabase.forTesting(super.e);

  @override
  int get schemaVersion => 3;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) async {
        await m.createAll();
      },
      onUpgrade: (Migrator m, int from, int to) async {
        if (from < 2) {
          // Add expiration_date column to lots table
          await m.addColumn(lots, lots.expirationDate);
        }
        if (from < 3) {
          // Add isActive column to sites and lots tables
          await m.addColumn(sites, sites.isActive);
          await m.addColumn(lots, lots.isActive);
        }
      },
    );
  }

  // Close the database
  @override
  Future<void> close() => executor.close();

  // Site operations
  Future<List<Site>> getAllSites() => select(sites).get();
  Future<List<Site>> getActiveSites() =>
      (select(sites)..where((s) => s.isActive.equals(true))).get();
  Future<Site> getSiteById(int id) =>
      (select(sites)..where((s) => s.id.equals(id))).getSingle();
  Future<int> insertSite(SitesCompanion site) => into(sites).insert(site);
  Future<bool> updateSite(Site site) => update(sites).replace(site);
  Future<int> deleteSite(int id) =>
      (delete(sites)..where((s) => s.id.equals(id))).go();

  // Lot operations
  Future<List<Lot>> getAllLots() => select(lots).get();
  Future<List<Lot>> getActiveLots() =>
      (select(lots)..where((l) => l.isActive.equals(true))).get();
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

  // Reports operations
  Future<List<InventorySnapshotWithDetails>> getInventoryByLotAcrossSites(
    int lotId,
  ) {
    final query =
        select(inventorySnapshots).join([
          innerJoin(sites, sites.id.equalsExp(inventorySnapshots.siteId)),
          innerJoin(lots, lots.id.equalsExp(inventorySnapshots.lotId)),
        ])..where(
          sites.isActive.equals(true) & inventorySnapshots.lotId.equals(lotId),
        );

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

  Future<List<InventorySnapshotWithDetails>> getLatestInventoryForSite(
    int siteId,
  ) async {
    // First get all active lots
    final activeLots = await getActiveLots();

    final results = <InventorySnapshotWithDetails>[];

    // For each active lot, get the latest inventory snapshot for the selected site
    for (final lot in activeLots) {
      final query =
          select(inventorySnapshots).join([
              innerJoin(sites, sites.id.equalsExp(inventorySnapshots.siteId)),
              innerJoin(lots, lots.id.equalsExp(inventorySnapshots.lotId)),
            ])
            ..where(
              inventorySnapshots.siteId.equals(siteId) &
                  inventorySnapshots.lotId.equals(lot.id),
            )
            ..orderBy([OrderingTerm.desc(inventorySnapshots.timestamp)])
            ..limit(1);

      final snapshotsForLot = await query.map((row) {
        final snapshot = row.readTable(inventorySnapshots);
        final site = row.readTable(sites);
        final lot = row.readTable(lots);

        return InventorySnapshotWithDetails(
          snapshot: snapshot,
          site: site,
          lot: lot,
        );
      }).get();

      if (snapshotsForLot.isNotEmpty) {
        results.add(snapshotsForLot.first);
      }
    }

    return results;
  }
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
