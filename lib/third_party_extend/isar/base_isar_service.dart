import 'dart:io';

import 'package:flutter_camelot/isar_extend.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

/// ```dart
/// class AppIsarService extends BaseIsarService {
//   static final AppIsarService _singleton = AppIsarService._();
//
//   AppIsarService._()
//       : super(
//           versionNumber: 1,
//           schemas: [
//             ...schema,
//           ],
//           migrations: [
//             ...migration
//           ],
//         );
//
//   factory AppIsarService() {
//     return _singleton;
//   }
/// ```
abstract class BaseIsarService {
  BaseIsarService({
    required this.versionNumber,
    required this.schemas,
    required this.migrations,
    this.directory,
  });

  final int versionNumber;

  final List<CollectionSchema> schemas;

  final List<BaseIsarMigration> migrations;

  final String? directory;

  CamelotIsar? _camelotIsar;

  CamelotIsar get camelotIsar {
    return _camelotIsar!;
  }

  Isar get isar {
    return camelotIsar.isar;
  }

  Future<Isar> open({bool reopen = false}) async {
    final dir = await getApplicationSupportDirectory();
    final camelotIsar = _camelotIsar ??= CamelotIsar(
      versionNumber: versionNumber,
      schemas: schemas,
      migrations: migrations,
      directory: directory ?? (Platform.isAndroid ? dir.path : dir.parent.path),
    );
    return await camelotIsar.open(reopen: reopen);
  }
}
