import 'package:isar/isar.dart';

abstract class BaseIsarMigration {
  BaseIsarMigration({
    required this.fromVersion,
    required this.toVersion,
  });

  final int fromVersion;

  final int toVersion;

  Future migrate(Isar isar);
}
