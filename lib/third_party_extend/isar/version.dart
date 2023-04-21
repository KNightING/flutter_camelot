import 'package:isar/isar.dart';

part 'generated/version.g.dart';

@collection
class Version {
  Id id = Isar.autoIncrement; // you can also use id = null to auto increment

  // can't use `version` to property's name
  late int ver;
}
