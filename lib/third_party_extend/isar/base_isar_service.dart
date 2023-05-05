import 'package:flutter_camelot/isar_extend.dart';
import 'package:isar/isar.dart';

abstract class BaseIsarService {
  BaseIsarService({
    required this.versionNumber,
    required this.schemas,
    required this.migrations,
  });

  final int versionNumber;

  final List<CollectionSchema> schemas;

  final List<BaseIsarMigration> migrations;

  CamelotIsar? _camelotIsar;

  CamelotIsar get camelotIsar {
    return _camelotIsar!;
  }

  Isar get isar {
    return camelotIsar.isar;
  }

  Future<Isar> open({bool reopen = false}) async {
    final camelotIsar = _camelotIsar ??= CamelotIsar(
        versionNumber: versionNumber, schemas: schemas, migrations: migrations);
    return await camelotIsar.open(reopen: reopen);
  }
}
