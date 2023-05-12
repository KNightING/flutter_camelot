import 'package:flutter_camelot/extension.dart';
import 'package:flutter_camelot/third_party_extend/isar/version.dart';
import 'package:isar/isar.dart';

import 'base_isar_migration.dart';

class CamelotIsar {
  CamelotIsar({
    required this.versionNumber,
    required this.schemas,
    required this.migrations,
    this.name = Isar.defaultName,
    required this.directory,
    this.inspector = true,
    this.compactOnLaunch,
    this.relaxedDurability = true,
    this.maxSizeMiB = Isar.defaultMaxSizeMiB,
  });

  final String name;

  final int versionNumber;

  final List<CollectionSchema> schemas;

  final List<BaseIsarMigration> migrations;

  final String directory;

  final int maxSizeMiB;

  final bool relaxedDurability;

  final CompactCondition? compactOnLaunch;

  final bool inspector;

  Isar? _versionIsar;

  Isar get versionIsar {
    return _versionIsar!;
  }

  Isar? _isar;

  Isar get isar {
    return _isar!;
  }

  Future<Version?> getVersion() async {
    return await _versionIsar!.versions.filter().idEqualTo(1).findFirst();
  }

  Future<int> putVersion(int version) async {
    return await _versionIsar!.writeTxn(() async {
      final newVersion = Version()
        ..id = 1
        ..ver = version;
      return await _versionIsar!.versions.put(newVersion);
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

      _isar ??= await Isar.open(
        schemas,
        directory: directory,
        name: name,
        compactOnLaunch: compactOnLaunch,
        inspector: inspector,
        maxSizeMiB: maxSizeMiB,
        relaxedDurability: relaxedDurability,
      );

      _versionIsar ??= await Isar.open(
        [VersionSchema],
        directory: directory,
        name: '${name}_version',
      );

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
