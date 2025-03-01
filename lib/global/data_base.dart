import 'package:isar/isar.dart';
import 'package:jijiwa_tool/database/game.dart';
import 'package:jijiwa_tool/database/player.dart';
import 'package:jijiwa_tool/database/score_edit.dart';
import 'package:jijiwa_tool/database/cache.dart';
import 'package:path_provider/path_provider.dart';

late Isar isar;

/// 数据库，也包含数据向云端的同步函数
abstract class DataBase {
  static init() async {
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open(
      [
        GameSchema,
        ScoreEditSchema,
        PlayerSchema,
        IsarCacheItemSchema,
      ],
      directory: dir.path,
    );
  }
}
