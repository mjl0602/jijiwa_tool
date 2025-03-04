import 'package:isar/isar.dart';

part 'score_edit.g.dart';

// 运行 dart run build_runner build
@collection
class ScoreEdit {
  Id id = Isar.autoIncrement;

  int? gameId;

  int? playerId;

  String? description;

  int score = 0;

  int previousScore = 0;

  DateTime? recordAt;

  ScoreEdit({
    this.gameId,
    this.playerId,
    this.score = 0,
    this.previousScore = 0,
    this.description,
    this.recordAt,
  });
}
