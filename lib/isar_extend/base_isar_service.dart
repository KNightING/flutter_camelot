import 'package:flutter_camelot/extension.dart';
import 'package:flutter_camelot/isar_extend/version.dart';
import 'package:isar/isar.dart';

import 'base_isar_migration.dart';

abstract class BaseIsarService {
  BaseIsarService({
    required this.versionNumber,
    required this.schemas,
    required this.migrations,
  });

  final int versionNumber;

  final List<CollectionSchema> schemas;

  final List<BaseIsarMigration> migrations;

  Isar? _isar;

  Isar get isar {
    return _isar!;
  }

  Future<Version?> getVersion() async {
    return await _isar!.versions.filter().idEqualTo(1).findFirst();
  }

  Future<int> putVersion(int version) async {
    return await _isar!.writeTxn(() async {
      final newVersion = Version()
        ..id = 1
        ..ver = version;
      return await _isar!.versions.put(newVersion);
    });
  }

  Future<Isar> open({bool reopen = false}) async {
    if (_isar == null || reopen) {
      await _isar?.let((it) async {
        if (reopen && it.isOpen) {
          await it.close();
          _isar = null;
        }

        if (!it.isOpen) {
          _isar = null;
        }
      });

      _isar ??= await Isar.open(schemas..add(VersionSchema));

      Version? currentVersion = await getVersion();
      if (currentVersion == null) {
        await putVersion(versionNumber);
      } else if (currentVersion.ver != versionNumber) {
        if (currentVersion.ver > versionNumber) {
          // database file's version is higher than code's version
          throw IsarMigrationVersionError(currentVersion.ver, versionNumber);
        }

        // do migration
        while (currentVersion!.ver != versionNumber) {
          final migration = migrations.firstOrNull(
              (element) => element.fromVersion == currentVersion!.ver);

          if (migration == null) {
            // not found migration
            throw IsarMigrationNotFoundError(currentVersion.ver);
          } else {
            await migration.migrate(_isar!);
            await putVersion(migration.toVersion);
            currentVersion = await getVersion();
          }
        }
      }
    }
    return _isar!;
  }
}

///
/// class IsarService extends BaseIsarService {
///   static final IsarService _singleton = IsarService._privateConstructor();
///
///  factory IsarService() {
///  return _singleton;
///  }
///
///  factory IsarService.on(Function(Isar isar) run, {bool reopen = false}) {
///  return _singleton.also((it) async {
///  run.call(await it.open(reopen: reopen));
///  });
///  }
///
///  IsarService._privateConstructor()
///  : super(
///  versionNumber: 1,
///  schemas: [],
///  migrations: [],
///  );
///  }
///

class IsarMigrationNotFoundError extends Error {
  IsarMigrationNotFoundError(this.fromVersion);

  final int fromVersion;

  @override
  String toString() {
    return 'IsarMigrationNotFoundError: plz add migration for version: $fromVersion';
  }
}

class IsarMigrationVersionError extends Error {
  IsarMigrationVersionError(this.currentVersion, this.newVersion);

  final int currentVersion;

  final int newVersion;

  @override
  String toString() {
    return 'IsarMigrationVersionError: plz check database version, current is $currentVersion, new is $newVersion';
  }
}
