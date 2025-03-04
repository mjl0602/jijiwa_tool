// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'score_edit.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetScoreEditCollection on Isar {
  IsarCollection<ScoreEdit> get scoreEdits => this.collection();
}

const ScoreEditSchema = CollectionSchema(
  name: r'ScoreEdit',
  id: -2651980429291311237,
  properties: {
    r'description': PropertySchema(
      id: 0,
      name: r'description',
      type: IsarType.string,
    ),
    r'gameId': PropertySchema(
      id: 1,
      name: r'gameId',
      type: IsarType.long,
    ),
    r'playerId': PropertySchema(
      id: 2,
      name: r'playerId',
      type: IsarType.long,
    ),
    r'previousScore': PropertySchema(
      id: 3,
      name: r'previousScore',
      type: IsarType.long,
    ),
    r'recordAt': PropertySchema(
      id: 4,
      name: r'recordAt',
      type: IsarType.dateTime,
    ),
    r'score': PropertySchema(
      id: 5,
      name: r'score',
      type: IsarType.long,
    )
  },
  estimateSize: _scoreEditEstimateSize,
  serialize: _scoreEditSerialize,
  deserialize: _scoreEditDeserialize,
  deserializeProp: _scoreEditDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _scoreEditGetId,
  getLinks: _scoreEditGetLinks,
  attach: _scoreEditAttach,
  version: '3.1.0+1',
);

int _scoreEditEstimateSize(
  ScoreEdit object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.description;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _scoreEditSerialize(
  ScoreEdit object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.description);
  writer.writeLong(offsets[1], object.gameId);
  writer.writeLong(offsets[2], object.playerId);
  writer.writeLong(offsets[3], object.previousScore);
  writer.writeDateTime(offsets[4], object.recordAt);
  writer.writeLong(offsets[5], object.score);
}

ScoreEdit _scoreEditDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = ScoreEdit(
    description: reader.readStringOrNull(offsets[0]),
    gameId: reader.readLongOrNull(offsets[1]),
    playerId: reader.readLongOrNull(offsets[2]),
    previousScore: reader.readLongOrNull(offsets[3]) ?? 0,
    recordAt: reader.readDateTimeOrNull(offsets[4]),
    score: reader.readLongOrNull(offsets[5]) ?? 0,
  );
  object.id = id;
  return object;
}

P _scoreEditDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset)) as P;
    case 1:
      return (reader.readLongOrNull(offset)) as P;
    case 2:
      return (reader.readLongOrNull(offset)) as P;
    case 3:
      return (reader.readLongOrNull(offset) ?? 0) as P;
    case 4:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 5:
      return (reader.readLongOrNull(offset) ?? 0) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _scoreEditGetId(ScoreEdit object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _scoreEditGetLinks(ScoreEdit object) {
  return [];
}

void _scoreEditAttach(IsarCollection<dynamic> col, Id id, ScoreEdit object) {
  object.id = id;
}

extension ScoreEditQueryWhereSort
    on QueryBuilder<ScoreEdit, ScoreEdit, QWhere> {
  QueryBuilder<ScoreEdit, ScoreEdit, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension ScoreEditQueryWhere
    on QueryBuilder<ScoreEdit, ScoreEdit, QWhereClause> {
  QueryBuilder<ScoreEdit, ScoreEdit, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<ScoreEdit, ScoreEdit, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<ScoreEdit, ScoreEdit, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<ScoreEdit, ScoreEdit, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<ScoreEdit, ScoreEdit, QAfterWhereClause> idBetween(
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

extension ScoreEditQueryFilter
    on QueryBuilder<ScoreEdit, ScoreEdit, QFilterCondition> {
  QueryBuilder<ScoreEdit, ScoreEdit, QAfterFilterCondition>
      descriptionIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'description',
      ));
    });
  }

  QueryBuilder<ScoreEdit, ScoreEdit, QAfterFilterCondition>
      descriptionIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'description',
      ));
    });
  }

  QueryBuilder<ScoreEdit, ScoreEdit, QAfterFilterCondition> descriptionEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ScoreEdit, ScoreEdit, QAfterFilterCondition>
      descriptionGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ScoreEdit, ScoreEdit, QAfterFilterCondition> descriptionLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ScoreEdit, ScoreEdit, QAfterFilterCondition> descriptionBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'description',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ScoreEdit, ScoreEdit, QAfterFilterCondition>
      descriptionStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ScoreEdit, ScoreEdit, QAfterFilterCondition> descriptionEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ScoreEdit, ScoreEdit, QAfterFilterCondition> descriptionContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ScoreEdit, ScoreEdit, QAfterFilterCondition> descriptionMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'description',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ScoreEdit, ScoreEdit, QAfterFilterCondition>
      descriptionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'description',
        value: '',
      ));
    });
  }

  QueryBuilder<ScoreEdit, ScoreEdit, QAfterFilterCondition>
      descriptionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'description',
        value: '',
      ));
    });
  }

  QueryBuilder<ScoreEdit, ScoreEdit, QAfterFilterCondition> gameIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'gameId',
      ));
    });
  }

  QueryBuilder<ScoreEdit, ScoreEdit, QAfterFilterCondition> gameIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'gameId',
      ));
    });
  }

  QueryBuilder<ScoreEdit, ScoreEdit, QAfterFilterCondition> gameIdEqualTo(
      int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'gameId',
        value: value,
      ));
    });
  }

  QueryBuilder<ScoreEdit, ScoreEdit, QAfterFilterCondition> gameIdGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'gameId',
        value: value,
      ));
    });
  }

  QueryBuilder<ScoreEdit, ScoreEdit, QAfterFilterCondition> gameIdLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'gameId',
        value: value,
      ));
    });
  }

  QueryBuilder<ScoreEdit, ScoreEdit, QAfterFilterCondition> gameIdBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'gameId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ScoreEdit, ScoreEdit, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<ScoreEdit, ScoreEdit, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<ScoreEdit, ScoreEdit, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<ScoreEdit, ScoreEdit, QAfterFilterCondition> idBetween(
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

  QueryBuilder<ScoreEdit, ScoreEdit, QAfterFilterCondition> playerIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'playerId',
      ));
    });
  }

  QueryBuilder<ScoreEdit, ScoreEdit, QAfterFilterCondition>
      playerIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'playerId',
      ));
    });
  }

  QueryBuilder<ScoreEdit, ScoreEdit, QAfterFilterCondition> playerIdEqualTo(
      int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'playerId',
        value: value,
      ));
    });
  }

  QueryBuilder<ScoreEdit, ScoreEdit, QAfterFilterCondition> playerIdGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'playerId',
        value: value,
      ));
    });
  }

  QueryBuilder<ScoreEdit, ScoreEdit, QAfterFilterCondition> playerIdLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'playerId',
        value: value,
      ));
    });
  }

  QueryBuilder<ScoreEdit, ScoreEdit, QAfterFilterCondition> playerIdBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'playerId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ScoreEdit, ScoreEdit, QAfterFilterCondition>
      previousScoreEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'previousScore',
        value: value,
      ));
    });
  }

  QueryBuilder<ScoreEdit, ScoreEdit, QAfterFilterCondition>
      previousScoreGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'previousScore',
        value: value,
      ));
    });
  }

  QueryBuilder<ScoreEdit, ScoreEdit, QAfterFilterCondition>
      previousScoreLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'previousScore',
        value: value,
      ));
    });
  }

  QueryBuilder<ScoreEdit, ScoreEdit, QAfterFilterCondition>
      previousScoreBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'previousScore',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ScoreEdit, ScoreEdit, QAfterFilterCondition> recordAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'recordAt',
      ));
    });
  }

  QueryBuilder<ScoreEdit, ScoreEdit, QAfterFilterCondition>
      recordAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'recordAt',
      ));
    });
  }

  QueryBuilder<ScoreEdit, ScoreEdit, QAfterFilterCondition> recordAtEqualTo(
      DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'recordAt',
        value: value,
      ));
    });
  }

  QueryBuilder<ScoreEdit, ScoreEdit, QAfterFilterCondition> recordAtGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'recordAt',
        value: value,
      ));
    });
  }

  QueryBuilder<ScoreEdit, ScoreEdit, QAfterFilterCondition> recordAtLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'recordAt',
        value: value,
      ));
    });
  }

  QueryBuilder<ScoreEdit, ScoreEdit, QAfterFilterCondition> recordAtBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'recordAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ScoreEdit, ScoreEdit, QAfterFilterCondition> scoreEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'score',
        value: value,
      ));
    });
  }

  QueryBuilder<ScoreEdit, ScoreEdit, QAfterFilterCondition> scoreGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'score',
        value: value,
      ));
    });
  }

  QueryBuilder<ScoreEdit, ScoreEdit, QAfterFilterCondition> scoreLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'score',
        value: value,
      ));
    });
  }

  QueryBuilder<ScoreEdit, ScoreEdit, QAfterFilterCondition> scoreBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'score',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension ScoreEditQueryObject
    on QueryBuilder<ScoreEdit, ScoreEdit, QFilterCondition> {}

extension ScoreEditQueryLinks
    on QueryBuilder<ScoreEdit, ScoreEdit, QFilterCondition> {}

extension ScoreEditQuerySortBy on QueryBuilder<ScoreEdit, ScoreEdit, QSortBy> {
  QueryBuilder<ScoreEdit, ScoreEdit, QAfterSortBy> sortByDescription() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.asc);
    });
  }

  QueryBuilder<ScoreEdit, ScoreEdit, QAfterSortBy> sortByDescriptionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.desc);
    });
  }

  QueryBuilder<ScoreEdit, ScoreEdit, QAfterSortBy> sortByGameId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'gameId', Sort.asc);
    });
  }

  QueryBuilder<ScoreEdit, ScoreEdit, QAfterSortBy> sortByGameIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'gameId', Sort.desc);
    });
  }

  QueryBuilder<ScoreEdit, ScoreEdit, QAfterSortBy> sortByPlayerId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'playerId', Sort.asc);
    });
  }

  QueryBuilder<ScoreEdit, ScoreEdit, QAfterSortBy> sortByPlayerIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'playerId', Sort.desc);
    });
  }

  QueryBuilder<ScoreEdit, ScoreEdit, QAfterSortBy> sortByPreviousScore() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'previousScore', Sort.asc);
    });
  }

  QueryBuilder<ScoreEdit, ScoreEdit, QAfterSortBy> sortByPreviousScoreDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'previousScore', Sort.desc);
    });
  }

  QueryBuilder<ScoreEdit, ScoreEdit, QAfterSortBy> sortByRecordAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'recordAt', Sort.asc);
    });
  }

  QueryBuilder<ScoreEdit, ScoreEdit, QAfterSortBy> sortByRecordAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'recordAt', Sort.desc);
    });
  }

  QueryBuilder<ScoreEdit, ScoreEdit, QAfterSortBy> sortByScore() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'score', Sort.asc);
    });
  }

  QueryBuilder<ScoreEdit, ScoreEdit, QAfterSortBy> sortByScoreDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'score', Sort.desc);
    });
  }
}

extension ScoreEditQuerySortThenBy
    on QueryBuilder<ScoreEdit, ScoreEdit, QSortThenBy> {
  QueryBuilder<ScoreEdit, ScoreEdit, QAfterSortBy> thenByDescription() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.asc);
    });
  }

  QueryBuilder<ScoreEdit, ScoreEdit, QAfterSortBy> thenByDescriptionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.desc);
    });
  }

  QueryBuilder<ScoreEdit, ScoreEdit, QAfterSortBy> thenByGameId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'gameId', Sort.asc);
    });
  }

  QueryBuilder<ScoreEdit, ScoreEdit, QAfterSortBy> thenByGameIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'gameId', Sort.desc);
    });
  }

  QueryBuilder<ScoreEdit, ScoreEdit, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<ScoreEdit, ScoreEdit, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<ScoreEdit, ScoreEdit, QAfterSortBy> thenByPlayerId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'playerId', Sort.asc);
    });
  }

  QueryBuilder<ScoreEdit, ScoreEdit, QAfterSortBy> thenByPlayerIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'playerId', Sort.desc);
    });
  }

  QueryBuilder<ScoreEdit, ScoreEdit, QAfterSortBy> thenByPreviousScore() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'previousScore', Sort.asc);
    });
  }

  QueryBuilder<ScoreEdit, ScoreEdit, QAfterSortBy> thenByPreviousScoreDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'previousScore', Sort.desc);
    });
  }

  QueryBuilder<ScoreEdit, ScoreEdit, QAfterSortBy> thenByRecordAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'recordAt', Sort.asc);
    });
  }

  QueryBuilder<ScoreEdit, ScoreEdit, QAfterSortBy> thenByRecordAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'recordAt', Sort.desc);
    });
  }

  QueryBuilder<ScoreEdit, ScoreEdit, QAfterSortBy> thenByScore() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'score', Sort.asc);
    });
  }

  QueryBuilder<ScoreEdit, ScoreEdit, QAfterSortBy> thenByScoreDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'score', Sort.desc);
    });
  }
}

extension ScoreEditQueryWhereDistinct
    on QueryBuilder<ScoreEdit, ScoreEdit, QDistinct> {
  QueryBuilder<ScoreEdit, ScoreEdit, QDistinct> distinctByDescription(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'description', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ScoreEdit, ScoreEdit, QDistinct> distinctByGameId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'gameId');
    });
  }

  QueryBuilder<ScoreEdit, ScoreEdit, QDistinct> distinctByPlayerId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'playerId');
    });
  }

  QueryBuilder<ScoreEdit, ScoreEdit, QDistinct> distinctByPreviousScore() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'previousScore');
    });
  }

  QueryBuilder<ScoreEdit, ScoreEdit, QDistinct> distinctByRecordAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'recordAt');
    });
  }

  QueryBuilder<ScoreEdit, ScoreEdit, QDistinct> distinctByScore() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'score');
    });
  }
}

extension ScoreEditQueryProperty
    on QueryBuilder<ScoreEdit, ScoreEdit, QQueryProperty> {
  QueryBuilder<ScoreEdit, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<ScoreEdit, String?, QQueryOperations> descriptionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'description');
    });
  }

  QueryBuilder<ScoreEdit, int?, QQueryOperations> gameIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'gameId');
    });
  }

  QueryBuilder<ScoreEdit, int?, QQueryOperations> playerIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'playerId');
    });
  }

  QueryBuilder<ScoreEdit, int, QQueryOperations> previousScoreProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'previousScore');
    });
  }

  QueryBuilder<ScoreEdit, DateTime?, QQueryOperations> recordAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'recordAt');
    });
  }

  QueryBuilder<ScoreEdit, int, QQueryOperations> scoreProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'score');
    });
  }
}
