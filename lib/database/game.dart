import 'package:isar/isar.dart';

part 'game.g.dart';

// 运行 dart run build_runner build
@collection
class Game {
  Id id = Isar.autoIncrement;

  String? gameName;

  String? roomName;

  DateTime? startAt;
  DateTime? endAt;

  Game({
    this.gameName,
    this.roomName,
    this.startAt,
    this.endAt,
  });
}
