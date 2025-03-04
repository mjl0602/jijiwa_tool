import 'package:isar/isar.dart';

part 'player.g.dart';

// 运行 dart run build_runner build
@collection
class Player {
  Id id = Isar.autoIncrement;

  // 房间号，为空时代表是常用玩家记录
  int? gameId;

  String? emoji;

  String? name;

  int score = 0;

  int color = 0;

  int sort = 0;

  DateTime? lastRecordAt;

  Player({
    this.gameId,
    this.emoji,
    this.name,
    this.score = 0,
    this.color = 0,
    this.sort = 0,
    this.lastRecordAt,
  });
}
