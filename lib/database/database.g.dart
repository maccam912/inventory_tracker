// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $SitesTable extends Sites with TableInfo<$SitesTable, Site> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SitesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _siteNameMeta = const VerificationMeta(
    'siteName',
  );
  @override
  late final GeneratedColumn<String> siteName = GeneratedColumn<String>(
    'site_name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 100,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, siteName];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sites';
  @override
  VerificationContext validateIntegrity(
    Insertable<Site> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('site_name')) {
      context.handle(
        _siteNameMeta,
        siteName.isAcceptableOrUnknown(data['site_name']!, _siteNameMeta),
      );
    } else if (isInserting) {
      context.missing(_siteNameMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Site map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Site(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      siteName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}site_name'],
      )!,
    );
  }

  @override
  $SitesTable createAlias(String alias) {
    return $SitesTable(attachedDatabase, alias);
  }
}

class Site extends DataClass implements Insertable<Site> {
  final int id;
  final String siteName;
  const Site({required this.id, required this.siteName});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['site_name'] = Variable<String>(siteName);
    return map;
  }

  SitesCompanion toCompanion(bool nullToAbsent) {
    return SitesCompanion(id: Value(id), siteName: Value(siteName));
  }

  factory Site.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Site(
      id: serializer.fromJson<int>(json['id']),
      siteName: serializer.fromJson<String>(json['siteName']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'siteName': serializer.toJson<String>(siteName),
    };
  }

  Site copyWith({int? id, String? siteName}) =>
      Site(id: id ?? this.id, siteName: siteName ?? this.siteName);
  Site copyWithCompanion(SitesCompanion data) {
    return Site(
      id: data.id.present ? data.id.value : this.id,
      siteName: data.siteName.present ? data.siteName.value : this.siteName,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Site(')
          ..write('id: $id, ')
          ..write('siteName: $siteName')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, siteName);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Site && other.id == this.id && other.siteName == this.siteName);
}

class SitesCompanion extends UpdateCompanion<Site> {
  final Value<int> id;
  final Value<String> siteName;
  const SitesCompanion({
    this.id = const Value.absent(),
    this.siteName = const Value.absent(),
  });
  SitesCompanion.insert({
    this.id = const Value.absent(),
    required String siteName,
  }) : siteName = Value(siteName);
  static Insertable<Site> custom({
    Expression<int>? id,
    Expression<String>? siteName,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (siteName != null) 'site_name': siteName,
    });
  }

  SitesCompanion copyWith({Value<int>? id, Value<String>? siteName}) {
    return SitesCompanion(
      id: id ?? this.id,
      siteName: siteName ?? this.siteName,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (siteName.present) {
      map['site_name'] = Variable<String>(siteName.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SitesCompanion(')
          ..write('id: $id, ')
          ..write('siteName: $siteName')
          ..write(')'))
        .toString();
  }
}

class $LotsTable extends Lots with TableInfo<$LotsTable, Lot> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LotsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _lotNumberMeta = const VerificationMeta(
    'lotNumber',
  );
  @override
  late final GeneratedColumn<String> lotNumber = GeneratedColumn<String>(
    'lot_number',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 50,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _expirationDateMeta = const VerificationMeta(
    'expirationDate',
  );
  @override
  late final GeneratedColumn<DateTime> expirationDate =
      GeneratedColumn<DateTime>(
        'expiration_date',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  @override
  List<GeneratedColumn> get $columns => [id, lotNumber, expirationDate];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'lots';
  @override
  VerificationContext validateIntegrity(
    Insertable<Lot> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('lot_number')) {
      context.handle(
        _lotNumberMeta,
        lotNumber.isAcceptableOrUnknown(data['lot_number']!, _lotNumberMeta),
      );
    } else if (isInserting) {
      context.missing(_lotNumberMeta);
    }
    if (data.containsKey('expiration_date')) {
      context.handle(
        _expirationDateMeta,
        expirationDate.isAcceptableOrUnknown(
          data['expiration_date']!,
          _expirationDateMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Lot map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Lot(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      lotNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}lot_number'],
      )!,
      expirationDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}expiration_date'],
      ),
    );
  }

  @override
  $LotsTable createAlias(String alias) {
    return $LotsTable(attachedDatabase, alias);
  }
}

class Lot extends DataClass implements Insertable<Lot> {
  final int id;
  final String lotNumber;
  final DateTime? expirationDate;
  const Lot({required this.id, required this.lotNumber, this.expirationDate});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['lot_number'] = Variable<String>(lotNumber);
    if (!nullToAbsent || expirationDate != null) {
      map['expiration_date'] = Variable<DateTime>(expirationDate);
    }
    return map;
  }

  LotsCompanion toCompanion(bool nullToAbsent) {
    return LotsCompanion(
      id: Value(id),
      lotNumber: Value(lotNumber),
      expirationDate: expirationDate == null && nullToAbsent
          ? const Value.absent()
          : Value(expirationDate),
    );
  }

  factory Lot.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Lot(
      id: serializer.fromJson<int>(json['id']),
      lotNumber: serializer.fromJson<String>(json['lotNumber']),
      expirationDate: serializer.fromJson<DateTime?>(json['expirationDate']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'lotNumber': serializer.toJson<String>(lotNumber),
      'expirationDate': serializer.toJson<DateTime?>(expirationDate),
    };
  }

  Lot copyWith({
    int? id,
    String? lotNumber,
    Value<DateTime?> expirationDate = const Value.absent(),
  }) => Lot(
    id: id ?? this.id,
    lotNumber: lotNumber ?? this.lotNumber,
    expirationDate: expirationDate.present
        ? expirationDate.value
        : this.expirationDate,
  );
  Lot copyWithCompanion(LotsCompanion data) {
    return Lot(
      id: data.id.present ? data.id.value : this.id,
      lotNumber: data.lotNumber.present ? data.lotNumber.value : this.lotNumber,
      expirationDate: data.expirationDate.present
          ? data.expirationDate.value
          : this.expirationDate,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Lot(')
          ..write('id: $id, ')
          ..write('lotNumber: $lotNumber, ')
          ..write('expirationDate: $expirationDate')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, lotNumber, expirationDate);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Lot &&
          other.id == this.id &&
          other.lotNumber == this.lotNumber &&
          other.expirationDate == this.expirationDate);
}

class LotsCompanion extends UpdateCompanion<Lot> {
  final Value<int> id;
  final Value<String> lotNumber;
  final Value<DateTime?> expirationDate;
  const LotsCompanion({
    this.id = const Value.absent(),
    this.lotNumber = const Value.absent(),
    this.expirationDate = const Value.absent(),
  });
  LotsCompanion.insert({
    this.id = const Value.absent(),
    required String lotNumber,
    this.expirationDate = const Value.absent(),
  }) : lotNumber = Value(lotNumber);
  static Insertable<Lot> custom({
    Expression<int>? id,
    Expression<String>? lotNumber,
    Expression<DateTime>? expirationDate,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (lotNumber != null) 'lot_number': lotNumber,
      if (expirationDate != null) 'expiration_date': expirationDate,
    });
  }

  LotsCompanion copyWith({
    Value<int>? id,
    Value<String>? lotNumber,
    Value<DateTime?>? expirationDate,
  }) {
    return LotsCompanion(
      id: id ?? this.id,
      lotNumber: lotNumber ?? this.lotNumber,
      expirationDate: expirationDate ?? this.expirationDate,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (lotNumber.present) {
      map['lot_number'] = Variable<String>(lotNumber.value);
    }
    if (expirationDate.present) {
      map['expiration_date'] = Variable<DateTime>(expirationDate.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LotsCompanion(')
          ..write('id: $id, ')
          ..write('lotNumber: $lotNumber, ')
          ..write('expirationDate: $expirationDate')
          ..write(')'))
        .toString();
  }
}

class $InventorySnapshotsTable extends InventorySnapshots
    with TableInfo<$InventorySnapshotsTable, InventorySnapshot> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $InventorySnapshotsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _siteIdMeta = const VerificationMeta('siteId');
  @override
  late final GeneratedColumn<int> siteId = GeneratedColumn<int>(
    'site_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES sites (id)',
    ),
  );
  static const VerificationMeta _lotIdMeta = const VerificationMeta('lotId');
  @override
  late final GeneratedColumn<int> lotId = GeneratedColumn<int>(
    'lot_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES lots (id)',
    ),
  );
  static const VerificationMeta _countMeta = const VerificationMeta('count');
  @override
  late final GeneratedColumn<int> count = GeneratedColumn<int>(
    'count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _timestampMeta = const VerificationMeta(
    'timestamp',
  );
  @override
  late final GeneratedColumn<DateTime> timestamp = GeneratedColumn<DateTime>(
    'timestamp',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: Constant(DateTime.now()),
  );
  @override
  List<GeneratedColumn> get $columns => [id, siteId, lotId, count, timestamp];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'inventory_snapshots';
  @override
  VerificationContext validateIntegrity(
    Insertable<InventorySnapshot> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('site_id')) {
      context.handle(
        _siteIdMeta,
        siteId.isAcceptableOrUnknown(data['site_id']!, _siteIdMeta),
      );
    } else if (isInserting) {
      context.missing(_siteIdMeta);
    }
    if (data.containsKey('lot_id')) {
      context.handle(
        _lotIdMeta,
        lotId.isAcceptableOrUnknown(data['lot_id']!, _lotIdMeta),
      );
    } else if (isInserting) {
      context.missing(_lotIdMeta);
    }
    if (data.containsKey('count')) {
      context.handle(
        _countMeta,
        count.isAcceptableOrUnknown(data['count']!, _countMeta),
      );
    } else if (isInserting) {
      context.missing(_countMeta);
    }
    if (data.containsKey('timestamp')) {
      context.handle(
        _timestampMeta,
        timestamp.isAcceptableOrUnknown(data['timestamp']!, _timestampMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  InventorySnapshot map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return InventorySnapshot(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      siteId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}site_id'],
      )!,
      lotId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}lot_id'],
      )!,
      count: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}count'],
      )!,
      timestamp: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}timestamp'],
      )!,
    );
  }

  @override
  $InventorySnapshotsTable createAlias(String alias) {
    return $InventorySnapshotsTable(attachedDatabase, alias);
  }
}

class InventorySnapshot extends DataClass
    implements Insertable<InventorySnapshot> {
  final int id;
  final int siteId;
  final int lotId;
  final int count;
  final DateTime timestamp;
  const InventorySnapshot({
    required this.id,
    required this.siteId,
    required this.lotId,
    required this.count,
    required this.timestamp,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['site_id'] = Variable<int>(siteId);
    map['lot_id'] = Variable<int>(lotId);
    map['count'] = Variable<int>(count);
    map['timestamp'] = Variable<DateTime>(timestamp);
    return map;
  }

  InventorySnapshotsCompanion toCompanion(bool nullToAbsent) {
    return InventorySnapshotsCompanion(
      id: Value(id),
      siteId: Value(siteId),
      lotId: Value(lotId),
      count: Value(count),
      timestamp: Value(timestamp),
    );
  }

  factory InventorySnapshot.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return InventorySnapshot(
      id: serializer.fromJson<int>(json['id']),
      siteId: serializer.fromJson<int>(json['siteId']),
      lotId: serializer.fromJson<int>(json['lotId']),
      count: serializer.fromJson<int>(json['count']),
      timestamp: serializer.fromJson<DateTime>(json['timestamp']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'siteId': serializer.toJson<int>(siteId),
      'lotId': serializer.toJson<int>(lotId),
      'count': serializer.toJson<int>(count),
      'timestamp': serializer.toJson<DateTime>(timestamp),
    };
  }

  InventorySnapshot copyWith({
    int? id,
    int? siteId,
    int? lotId,
    int? count,
    DateTime? timestamp,
  }) => InventorySnapshot(
    id: id ?? this.id,
    siteId: siteId ?? this.siteId,
    lotId: lotId ?? this.lotId,
    count: count ?? this.count,
    timestamp: timestamp ?? this.timestamp,
  );
  InventorySnapshot copyWithCompanion(InventorySnapshotsCompanion data) {
    return InventorySnapshot(
      id: data.id.present ? data.id.value : this.id,
      siteId: data.siteId.present ? data.siteId.value : this.siteId,
      lotId: data.lotId.present ? data.lotId.value : this.lotId,
      count: data.count.present ? data.count.value : this.count,
      timestamp: data.timestamp.present ? data.timestamp.value : this.timestamp,
    );
  }

  @override
  String toString() {
    return (StringBuffer('InventorySnapshot(')
          ..write('id: $id, ')
          ..write('siteId: $siteId, ')
          ..write('lotId: $lotId, ')
          ..write('count: $count, ')
          ..write('timestamp: $timestamp')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, siteId, lotId, count, timestamp);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is InventorySnapshot &&
          other.id == this.id &&
          other.siteId == this.siteId &&
          other.lotId == this.lotId &&
          other.count == this.count &&
          other.timestamp == this.timestamp);
}

class InventorySnapshotsCompanion extends UpdateCompanion<InventorySnapshot> {
  final Value<int> id;
  final Value<int> siteId;
  final Value<int> lotId;
  final Value<int> count;
  final Value<DateTime> timestamp;
  const InventorySnapshotsCompanion({
    this.id = const Value.absent(),
    this.siteId = const Value.absent(),
    this.lotId = const Value.absent(),
    this.count = const Value.absent(),
    this.timestamp = const Value.absent(),
  });
  InventorySnapshotsCompanion.insert({
    this.id = const Value.absent(),
    required int siteId,
    required int lotId,
    required int count,
    this.timestamp = const Value.absent(),
  }) : siteId = Value(siteId),
       lotId = Value(lotId),
       count = Value(count);
  static Insertable<InventorySnapshot> custom({
    Expression<int>? id,
    Expression<int>? siteId,
    Expression<int>? lotId,
    Expression<int>? count,
    Expression<DateTime>? timestamp,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (siteId != null) 'site_id': siteId,
      if (lotId != null) 'lot_id': lotId,
      if (count != null) 'count': count,
      if (timestamp != null) 'timestamp': timestamp,
    });
  }

  InventorySnapshotsCompanion copyWith({
    Value<int>? id,
    Value<int>? siteId,
    Value<int>? lotId,
    Value<int>? count,
    Value<DateTime>? timestamp,
  }) {
    return InventorySnapshotsCompanion(
      id: id ?? this.id,
      siteId: siteId ?? this.siteId,
      lotId: lotId ?? this.lotId,
      count: count ?? this.count,
      timestamp: timestamp ?? this.timestamp,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (siteId.present) {
      map['site_id'] = Variable<int>(siteId.value);
    }
    if (lotId.present) {
      map['lot_id'] = Variable<int>(lotId.value);
    }
    if (count.present) {
      map['count'] = Variable<int>(count.value);
    }
    if (timestamp.present) {
      map['timestamp'] = Variable<DateTime>(timestamp.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('InventorySnapshotsCompanion(')
          ..write('id: $id, ')
          ..write('siteId: $siteId, ')
          ..write('lotId: $lotId, ')
          ..write('count: $count, ')
          ..write('timestamp: $timestamp')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $SitesTable sites = $SitesTable(this);
  late final $LotsTable lots = $LotsTable(this);
  late final $InventorySnapshotsTable inventorySnapshots =
      $InventorySnapshotsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    sites,
    lots,
    inventorySnapshots,
  ];
}

typedef $$SitesTableCreateCompanionBuilder =
    SitesCompanion Function({Value<int> id, required String siteName});
typedef $$SitesTableUpdateCompanionBuilder =
    SitesCompanion Function({Value<int> id, Value<String> siteName});

final class $$SitesTableReferences
    extends BaseReferences<_$AppDatabase, $SitesTable, Site> {
  $$SitesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$InventorySnapshotsTable, List<InventorySnapshot>>
  _inventorySnapshotsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.inventorySnapshots,
        aliasName: $_aliasNameGenerator(
          db.sites.id,
          db.inventorySnapshots.siteId,
        ),
      );

  $$InventorySnapshotsTableProcessedTableManager get inventorySnapshotsRefs {
    final manager = $$InventorySnapshotsTableTableManager(
      $_db,
      $_db.inventorySnapshots,
    ).filter((f) => f.siteId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _inventorySnapshotsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$SitesTableFilterComposer extends Composer<_$AppDatabase, $SitesTable> {
  $$SitesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get siteName => $composableBuilder(
    column: $table.siteName,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> inventorySnapshotsRefs(
    Expression<bool> Function($$InventorySnapshotsTableFilterComposer f) f,
  ) {
    final $$InventorySnapshotsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.inventorySnapshots,
      getReferencedColumn: (t) => t.siteId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InventorySnapshotsTableFilterComposer(
            $db: $db,
            $table: $db.inventorySnapshots,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$SitesTableOrderingComposer
    extends Composer<_$AppDatabase, $SitesTable> {
  $$SitesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get siteName => $composableBuilder(
    column: $table.siteName,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SitesTableAnnotationComposer
    extends Composer<_$AppDatabase, $SitesTable> {
  $$SitesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get siteName =>
      $composableBuilder(column: $table.siteName, builder: (column) => column);

  Expression<T> inventorySnapshotsRefs<T extends Object>(
    Expression<T> Function($$InventorySnapshotsTableAnnotationComposer a) f,
  ) {
    final $$InventorySnapshotsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.inventorySnapshots,
          getReferencedColumn: (t) => t.siteId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$InventorySnapshotsTableAnnotationComposer(
                $db: $db,
                $table: $db.inventorySnapshots,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$SitesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SitesTable,
          Site,
          $$SitesTableFilterComposer,
          $$SitesTableOrderingComposer,
          $$SitesTableAnnotationComposer,
          $$SitesTableCreateCompanionBuilder,
          $$SitesTableUpdateCompanionBuilder,
          (Site, $$SitesTableReferences),
          Site,
          PrefetchHooks Function({bool inventorySnapshotsRefs})
        > {
  $$SitesTableTableManager(_$AppDatabase db, $SitesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SitesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SitesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SitesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> siteName = const Value.absent(),
              }) => SitesCompanion(id: id, siteName: siteName),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String siteName,
              }) => SitesCompanion.insert(id: id, siteName: siteName),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$SitesTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback: ({inventorySnapshotsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (inventorySnapshotsRefs) db.inventorySnapshots,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (inventorySnapshotsRefs)
                    await $_getPrefetchedData<
                      Site,
                      $SitesTable,
                      InventorySnapshot
                    >(
                      currentTable: table,
                      referencedTable: $$SitesTableReferences
                          ._inventorySnapshotsRefsTable(db),
                      managerFromTypedResult: (p0) => $$SitesTableReferences(
                        db,
                        table,
                        p0,
                      ).inventorySnapshotsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.siteId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$SitesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SitesTable,
      Site,
      $$SitesTableFilterComposer,
      $$SitesTableOrderingComposer,
      $$SitesTableAnnotationComposer,
      $$SitesTableCreateCompanionBuilder,
      $$SitesTableUpdateCompanionBuilder,
      (Site, $$SitesTableReferences),
      Site,
      PrefetchHooks Function({bool inventorySnapshotsRefs})
    >;
typedef $$LotsTableCreateCompanionBuilder =
    LotsCompanion Function({
      Value<int> id,
      required String lotNumber,
      Value<DateTime?> expirationDate,
    });
typedef $$LotsTableUpdateCompanionBuilder =
    LotsCompanion Function({
      Value<int> id,
      Value<String> lotNumber,
      Value<DateTime?> expirationDate,
    });

final class $$LotsTableReferences
    extends BaseReferences<_$AppDatabase, $LotsTable, Lot> {
  $$LotsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$InventorySnapshotsTable, List<InventorySnapshot>>
  _inventorySnapshotsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.inventorySnapshots,
        aliasName: $_aliasNameGenerator(
          db.lots.id,
          db.inventorySnapshots.lotId,
        ),
      );

  $$InventorySnapshotsTableProcessedTableManager get inventorySnapshotsRefs {
    final manager = $$InventorySnapshotsTableTableManager(
      $_db,
      $_db.inventorySnapshots,
    ).filter((f) => f.lotId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _inventorySnapshotsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$LotsTableFilterComposer extends Composer<_$AppDatabase, $LotsTable> {
  $$LotsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lotNumber => $composableBuilder(
    column: $table.lotNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get expirationDate => $composableBuilder(
    column: $table.expirationDate,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> inventorySnapshotsRefs(
    Expression<bool> Function($$InventorySnapshotsTableFilterComposer f) f,
  ) {
    final $$InventorySnapshotsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.inventorySnapshots,
      getReferencedColumn: (t) => t.lotId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InventorySnapshotsTableFilterComposer(
            $db: $db,
            $table: $db.inventorySnapshots,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$LotsTableOrderingComposer extends Composer<_$AppDatabase, $LotsTable> {
  $$LotsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lotNumber => $composableBuilder(
    column: $table.lotNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get expirationDate => $composableBuilder(
    column: $table.expirationDate,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$LotsTableAnnotationComposer
    extends Composer<_$AppDatabase, $LotsTable> {
  $$LotsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get lotNumber =>
      $composableBuilder(column: $table.lotNumber, builder: (column) => column);

  GeneratedColumn<DateTime> get expirationDate => $composableBuilder(
    column: $table.expirationDate,
    builder: (column) => column,
  );

  Expression<T> inventorySnapshotsRefs<T extends Object>(
    Expression<T> Function($$InventorySnapshotsTableAnnotationComposer a) f,
  ) {
    final $$InventorySnapshotsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.inventorySnapshots,
          getReferencedColumn: (t) => t.lotId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$InventorySnapshotsTableAnnotationComposer(
                $db: $db,
                $table: $db.inventorySnapshots,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$LotsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $LotsTable,
          Lot,
          $$LotsTableFilterComposer,
          $$LotsTableOrderingComposer,
          $$LotsTableAnnotationComposer,
          $$LotsTableCreateCompanionBuilder,
          $$LotsTableUpdateCompanionBuilder,
          (Lot, $$LotsTableReferences),
          Lot,
          PrefetchHooks Function({bool inventorySnapshotsRefs})
        > {
  $$LotsTableTableManager(_$AppDatabase db, $LotsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LotsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LotsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LotsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> lotNumber = const Value.absent(),
                Value<DateTime?> expirationDate = const Value.absent(),
              }) => LotsCompanion(
                id: id,
                lotNumber: lotNumber,
                expirationDate: expirationDate,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String lotNumber,
                Value<DateTime?> expirationDate = const Value.absent(),
              }) => LotsCompanion.insert(
                id: id,
                lotNumber: lotNumber,
                expirationDate: expirationDate,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$LotsTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback: ({inventorySnapshotsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (inventorySnapshotsRefs) db.inventorySnapshots,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (inventorySnapshotsRefs)
                    await $_getPrefetchedData<
                      Lot,
                      $LotsTable,
                      InventorySnapshot
                    >(
                      currentTable: table,
                      referencedTable: $$LotsTableReferences
                          ._inventorySnapshotsRefsTable(db),
                      managerFromTypedResult: (p0) => $$LotsTableReferences(
                        db,
                        table,
                        p0,
                      ).inventorySnapshotsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.lotId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$LotsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $LotsTable,
      Lot,
      $$LotsTableFilterComposer,
      $$LotsTableOrderingComposer,
      $$LotsTableAnnotationComposer,
      $$LotsTableCreateCompanionBuilder,
      $$LotsTableUpdateCompanionBuilder,
      (Lot, $$LotsTableReferences),
      Lot,
      PrefetchHooks Function({bool inventorySnapshotsRefs})
    >;
typedef $$InventorySnapshotsTableCreateCompanionBuilder =
    InventorySnapshotsCompanion Function({
      Value<int> id,
      required int siteId,
      required int lotId,
      required int count,
      Value<DateTime> timestamp,
    });
typedef $$InventorySnapshotsTableUpdateCompanionBuilder =
    InventorySnapshotsCompanion Function({
      Value<int> id,
      Value<int> siteId,
      Value<int> lotId,
      Value<int> count,
      Value<DateTime> timestamp,
    });

final class $$InventorySnapshotsTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $InventorySnapshotsTable,
          InventorySnapshot
        > {
  $$InventorySnapshotsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $SitesTable _siteIdTable(_$AppDatabase db) => db.sites.createAlias(
    $_aliasNameGenerator(db.inventorySnapshots.siteId, db.sites.id),
  );

  $$SitesTableProcessedTableManager get siteId {
    final $_column = $_itemColumn<int>('site_id')!;

    final manager = $$SitesTableTableManager(
      $_db,
      $_db.sites,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_siteIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $LotsTable _lotIdTable(_$AppDatabase db) => db.lots.createAlias(
    $_aliasNameGenerator(db.inventorySnapshots.lotId, db.lots.id),
  );

  $$LotsTableProcessedTableManager get lotId {
    final $_column = $_itemColumn<int>('lot_id')!;

    final manager = $$LotsTableTableManager(
      $_db,
      $_db.lots,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_lotIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$InventorySnapshotsTableFilterComposer
    extends Composer<_$AppDatabase, $InventorySnapshotsTable> {
  $$InventorySnapshotsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get count => $composableBuilder(
    column: $table.count,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get timestamp => $composableBuilder(
    column: $table.timestamp,
    builder: (column) => ColumnFilters(column),
  );

  $$SitesTableFilterComposer get siteId {
    final $$SitesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.siteId,
      referencedTable: $db.sites,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SitesTableFilterComposer(
            $db: $db,
            $table: $db.sites,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$LotsTableFilterComposer get lotId {
    final $$LotsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.lotId,
      referencedTable: $db.lots,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LotsTableFilterComposer(
            $db: $db,
            $table: $db.lots,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$InventorySnapshotsTableOrderingComposer
    extends Composer<_$AppDatabase, $InventorySnapshotsTable> {
  $$InventorySnapshotsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get count => $composableBuilder(
    column: $table.count,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get timestamp => $composableBuilder(
    column: $table.timestamp,
    builder: (column) => ColumnOrderings(column),
  );

  $$SitesTableOrderingComposer get siteId {
    final $$SitesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.siteId,
      referencedTable: $db.sites,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SitesTableOrderingComposer(
            $db: $db,
            $table: $db.sites,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$LotsTableOrderingComposer get lotId {
    final $$LotsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.lotId,
      referencedTable: $db.lots,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LotsTableOrderingComposer(
            $db: $db,
            $table: $db.lots,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$InventorySnapshotsTableAnnotationComposer
    extends Composer<_$AppDatabase, $InventorySnapshotsTable> {
  $$InventorySnapshotsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get count =>
      $composableBuilder(column: $table.count, builder: (column) => column);

  GeneratedColumn<DateTime> get timestamp =>
      $composableBuilder(column: $table.timestamp, builder: (column) => column);

  $$SitesTableAnnotationComposer get siteId {
    final $$SitesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.siteId,
      referencedTable: $db.sites,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SitesTableAnnotationComposer(
            $db: $db,
            $table: $db.sites,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$LotsTableAnnotationComposer get lotId {
    final $$LotsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.lotId,
      referencedTable: $db.lots,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LotsTableAnnotationComposer(
            $db: $db,
            $table: $db.lots,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$InventorySnapshotsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $InventorySnapshotsTable,
          InventorySnapshot,
          $$InventorySnapshotsTableFilterComposer,
          $$InventorySnapshotsTableOrderingComposer,
          $$InventorySnapshotsTableAnnotationComposer,
          $$InventorySnapshotsTableCreateCompanionBuilder,
          $$InventorySnapshotsTableUpdateCompanionBuilder,
          (InventorySnapshot, $$InventorySnapshotsTableReferences),
          InventorySnapshot,
          PrefetchHooks Function({bool siteId, bool lotId})
        > {
  $$InventorySnapshotsTableTableManager(
    _$AppDatabase db,
    $InventorySnapshotsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$InventorySnapshotsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$InventorySnapshotsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$InventorySnapshotsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> siteId = const Value.absent(),
                Value<int> lotId = const Value.absent(),
                Value<int> count = const Value.absent(),
                Value<DateTime> timestamp = const Value.absent(),
              }) => InventorySnapshotsCompanion(
                id: id,
                siteId: siteId,
                lotId: lotId,
                count: count,
                timestamp: timestamp,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int siteId,
                required int lotId,
                required int count,
                Value<DateTime> timestamp = const Value.absent(),
              }) => InventorySnapshotsCompanion.insert(
                id: id,
                siteId: siteId,
                lotId: lotId,
                count: count,
                timestamp: timestamp,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$InventorySnapshotsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({siteId = false, lotId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (siteId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.siteId,
                                referencedTable:
                                    $$InventorySnapshotsTableReferences
                                        ._siteIdTable(db),
                                referencedColumn:
                                    $$InventorySnapshotsTableReferences
                                        ._siteIdTable(db)
                                        .id,
                              )
                              as T;
                    }
                    if (lotId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.lotId,
                                referencedTable:
                                    $$InventorySnapshotsTableReferences
                                        ._lotIdTable(db),
                                referencedColumn:
                                    $$InventorySnapshotsTableReferences
                                        ._lotIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$InventorySnapshotsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $InventorySnapshotsTable,
      InventorySnapshot,
      $$InventorySnapshotsTableFilterComposer,
      $$InventorySnapshotsTableOrderingComposer,
      $$InventorySnapshotsTableAnnotationComposer,
      $$InventorySnapshotsTableCreateCompanionBuilder,
      $$InventorySnapshotsTableUpdateCompanionBuilder,
      (InventorySnapshot, $$InventorySnapshotsTableReferences),
      InventorySnapshot,
      PrefetchHooks Function({bool siteId, bool lotId})
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$SitesTableTableManager get sites =>
      $$SitesTableTableManager(_db, _db.sites);
  $$LotsTableTableManager get lots => $$LotsTableTableManager(_db, _db.lots);
  $$InventorySnapshotsTableTableManager get inventorySnapshots =>
      $$InventorySnapshotsTableTableManager(_db, _db.inventorySnapshots);
}
