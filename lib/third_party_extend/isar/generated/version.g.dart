// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../version.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters

extension GetVersionCollection on Isar {
  IsarCollection<Version> get versions => this.collection();
}

const VersionSchema = CollectionSchema(
  name: r'Version',
  id: 1032601149805461396,
  properties: {
    r'ver': PropertySchema(
      id: 0,
      name: r'ver',
      type: IsarType.long,
    )
  },
  estimateSize: _versionEstimateSize,
  serialize: _versionSerialize,
  deserialize: _versionDeserialize,
  deserializeProp: _versionDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _versionGetId,
  getLinks: _versionGetLinks,
  attach: _versionAttach,
  version: '3.0.5',
);

int _versionEstimateSize(
  Version object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  return bytesCount;
}

void _versionSerialize(
  Version object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.ver);
}

Version _versionDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Version();
  object.id = id;
  object.ver = reader.readLong(offsets[0]);
  return object;
}

P _versionDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLong(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _versionGetId(Version object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _versionGetLinks(Version object) {
  return [];
}

void _versionAttach(IsarCollection<dynamic> col, Id id, Version object) {
  object.id = id;
}

extension VersionQueryWhereSort on QueryBuilder<Version, Version, QWhere> {
  QueryBuilder<Version, Version, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension VersionQueryWhere on QueryBuilder<Version, Version, QWhereClause> {
  QueryBuilder<Version, Version, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<Version, Version, QAfterWhereClause> idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<Version, Version, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<Version, Version, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<Version, Version, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension VersionQueryFilter
    on QueryBuilder<Version, Version, QFilterCondition> {
  QueryBuilder<Version, Version, QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Version, Version, QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Version, Version, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Version, Version, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Version, Version, QAfterFilterCondition> verEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'ver',
        value: value,
      ));
    });
  }

  QueryBuilder<Version, Version, QAfterFilterCondition> verGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'ver',
        value: value,
      ));
    });
  }

  QueryBuilder<Version, Version, QAfterFilterCondition> verLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'ver',
        value: value,
      ));
    });
  }

  QueryBuilder<Version, Version, QAfterFilterCondition> verBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'ver',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension VersionQueryObject
    on QueryBuilder<Version, Version, QFilterCondition> {}

extension VersionQueryLinks
    on QueryBuilder<Version, Version, QFilterCondition> {}

extension VersionQuerySortBy on QueryBuilder<Version, Version, QSortBy> {
  QueryBuilder<Version, Version, QAfterSortBy> sortByVer() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ver', Sort.asc);
    });
  }

  QueryBuilder<Version, Version, QAfterSortBy> sortByVerDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ver', Sort.desc);
    });
  }
}

extension VersionQuerySortThenBy
    on QueryBuilder<Version, Version, QSortThenBy> {
  QueryBuilder<Version, Version, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<Version, Version, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<Version, Version, QAfterSortBy> thenByVer() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ver', Sort.asc);
    });
  }

  QueryBuilder<Version, Version, QAfterSortBy> thenByVerDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ver', Sort.desc);
    });
  }
}

extension VersionQueryWhereDistinct
    on QueryBuilder<Version, Version, QDistinct> {
  QueryBuilder<Version, Version, QDistinct> distinctByVer() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'ver');
    });
  }
}

extension VersionQueryProperty
    on QueryBuilder<Version, Version, QQueryProperty> {
  QueryBuilder<Version, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<Version, int, QQueryOperations> verProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'ver');
    });
  }
}
