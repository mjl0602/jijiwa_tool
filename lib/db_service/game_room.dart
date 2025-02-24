import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:jijiwa_tool/config/emoji.dart';
import 'package:jijiwa_tool/database/game.dart';
import 'package:jijiwa_tool/database/player.dart';
import 'package:jijiwa_tool/database/score_edit.dart';
import 'package:jijiwa_tool/global/data_base.dart';

class GameRoom extends ChangeNotifier {
  Game? currentGame;
  List<Player> players = [];

  static List<String> get emojiList => allEmoji;
  // static List<Color> get colorList => [
  //       Color(0xffFF5733),
  //       Color(0xff33FF57),
  //       Color(0xff3357FF),
  //       Color(0xffF1C40F),
  //       Color(0xff8E44AD),
  //       Color(0xff3498DB),
  //       Color(0xff2ECC71),
  //       Color(0xffE74C3C),
  //       Color(0xff1ABC9C),
  //       Color(0xff2C3E50),
  //       Color(0xffF39C12),
  //       Color(0xffD35400),
  //       Color(0xffC0392B),
  //       Color(0xffBDC3C7),
  //       Color(0xff7F8C8D),
  //       Color(0xff34495E),
  //       Color(0xff16A085),
  //       Color(0xff27AE60),
  //       Color(0xff2980B9),
  //       Color(0xffD35400),
  //       Color(0xffE74C3C),
  //     ];
  static List<Color> get colorList => [
        Colors.purpleAccent.shade100,
        Colors.purpleAccent.shade200,
        // Colors.purpleAccent.shade400,
        // Colors.purpleAccent.shade700,
        Colors.redAccent.shade100,
        Colors.redAccent.shade200,
        // Colors.redAccent.shade400,
        // Colors.redAccent.shade700,
        Colors.blueAccent.shade100,
        Colors.blueAccent.shade200,
        // Colors.blueAccent.shade400,
        // Colors.blueAccent.shade700,
        Colors.pinkAccent.shade100,
        Colors.pinkAccent.shade200,
        // Colors.pinkAccent.shade400,
        // Colors.pinkAccent.shade700,
        Colors.deepPurpleAccent.shade100,
        Colors.deepPurpleAccent.shade200,
        // Colors.deepPurpleAccent.shade400,
        // Colors.deepPurpleAccent.shade700,
        Colors.lightGreenAccent.shade100,
        Colors.lightGreenAccent.shade200,
        // Colors.lightGreenAccent.shade400,
        // Colors.lightGreenAccent.shade700,
        Colors.cyanAccent.shade100,
        Colors.cyanAccent.shade200,
        // Colors.cyanAccent.shade400,
        // Colors.cyanAccent.shade700,
        // Colors.tealAccent.shade100,
        // Colors.tealAccent.shade200,
        // Colors.tealAccent.shade400,
        // Colors.tealAccent.shade700,
        Colors.orangeAccent.shade100,
        Colors.orangeAccent.shade200,
        // Colors.orangeAccent.shade400,
        // Colors.orangeAccent.shade700,
      ];

  List<String> _emojiList = [];
  List<Color> _colorList = [];

  setRandomList() {
    _emojiList = [...emojiList]..shuffle();
    _colorList = [...colorList]..shuffle();
  }

  setRandomUserConfig() async {
    setRandomList();
    await isar.writeTxn(() async {
      int i = 0;
      for (final player in players) {
        player.emoji = _emojiList[i];
        player.color = _colorList[i].value;
        await isar.players.put(player);
        i++;
      }
    });
    notifyListeners();
  }

  restart() async {
    await isar.writeTxn(() async {
      for (final player in players) {
        player.score = 0;
        await isar.players.put(player);
        final scoreEdit = ScoreEdit(
          gameId: player.gameId,
          playerId: player.id,
          description: '=0',
          score: 0,
          recordAt: DateTime.now(),
        );
        await isar.scoreEdits.put(scoreEdit);
      }
    });
    notifyListeners();
  }

  undo() async {
    final list = await isar.scoreEdits
        .filter()
        .gameIdEqualTo(currentGame?.id)
        .recordAtIsNotNull()
        .sortByRecordAtDesc()
        .limit(100)
        .findAll();
    if (list.isEmpty) return;
    final slices = ScoreSlice.generateScoreSlices(list);
    final slice = slices.removeAt(0);
    await isar.writeTxn(() async {
      await isar.scoreEdits.deleteAll(slice.edits.map((e) => e.id).toList());
      if (slices.isEmpty) {
        for (var player in players) {
          player.score = 0;
        }
      } else {
        final config = slices.first.finalScores;
        for (var player in players) {
          if (config.containsKey(player.id)) {
            player.score = config[player.id]!;
          }
        }
      }
      await isar.players.putAll(players);
    });
    reloadPlayers();
  }

  Future<void> startGame() async {
    final games =
        await isar.games.filter().endAtIsNull().sortByStartAtDesc().findAll();
    setRandomList();
    if (games.isNotEmpty) {
      currentGame = games.first;
      players = await isar.players
          .filter()
          .gameIdEqualTo(currentGame?.id)
          .sortBySort()
          .findAll();
      notifyListeners();
      return;
    }

    await isar.writeTxn(() async {
      final game = Game(
        gameName: '',
        roomName: '',
        startAt: DateTime.now(),
      );
      final gameID = await isar.games.put(game);
      currentGame = game;

      players.clear();

      for (var i = 0; i < 4; i++) {
        final player = Player(
          gameId: gameID,
          emoji: _emojiList[i],
          color: _colorList[i].value,
          sort: i,
          score: 0,
        );
        await isar.players.put(player);
        players.add(player);
      }
    });
    notifyListeners();
  }

  Future<void> removePlayer([Player? player]) async {
    if (players.length == 1) return;
    await isar.writeTxn(() async {
      await isar.players
          .filter()
          .idEqualTo((player ?? players.last).id)
          .deleteAll();
    });
    await reloadPlayers();
    notifyListeners();
  }

  Future<void> addPlayer([Player? player]) async {
    if (players.length == 12) return;
    await isar.writeTxn(() async {
      await isar.players.put(Player(
        gameId: currentGame?.id,
        emoji: _emojiList[players.length],
        color: _colorList[players.length].value,
        sort: players.length,
        score: 0,
      ));
    });
    await reloadPlayers();
    notifyListeners();
  }

  Future<void> reloadPlayers() async {
    players = await isar.players
        .filter()
        .gameIdEqualTo(currentGame?.id)
        .sortBySort()
        .findAll();
    notifyListeners();
  }

  Future<void> putScore(
    Player player,
    int newScore,
    String description,
  ) async {
    await isar.writeTxn(() async {
      player.score = newScore;
      await isar.players.put(player);
      final scoreEdit = ScoreEdit(
        gameId: player.gameId,
        playerId: player.id,
        description: description,
        score: newScore,
        recordAt: DateTime.now(),
      );
      await isar.scoreEdits.put(scoreEdit);
    });
    notifyListeners();
  }
}

class ScoreSlice {
  List<ScoreEdit> edits;

  ScoreSlice(this.edits);

  // 计算并返回当前切片的最终分数状态
  Map<int, int> get finalScores {
    Map<int, int> scores = {};
    for (var edit in edits) {
      // 确保playerId不为空
      if (edit.playerId != null && !scores.containsKey(edit.playerId!)) {
        scores[edit.playerId!] = edit.score;
      }
    }
    return scores;
  }

  static List<ScoreSlice> generateScoreSlices(List<ScoreEdit> edits) {
    // 检查输入列表是否为空
    if (edits.isEmpty) {
      return [];
    }

    // 首先，确保edits按recordAt时间排序
    edits.sort((b, a) => a.recordAt!.compareTo(b.recordAt!));

    // 初始化结果列表
    List<ScoreSlice> slices = [];
    // 初始化当前切片列表，并将第一个编辑操作加入其中
    List<ScoreEdit> currentSliceEdits = [edits.first];

    // 从第二个编辑操作开始遍历
    for (int i = 1; i < edits.length; i++) {
      // 计算时间差
      Duration diff = edits[i - 1].recordAt!.difference(edits[i].recordAt!);
      // 如果时间差大于1秒，开始一个新的切片
      if (diff.inSeconds > 1) {
        // 将当前切片加入到结果列表中
        slices.add(ScoreSlice(currentSliceEdits));
        // 重置当前切片为一个新的列表，包含当前编辑操作
        currentSliceEdits = [edits[i]];
      } else {
        // 否则，将当前编辑操作加入到当前切片中
        currentSliceEdits.add(edits[i]);
      }
    }

    // 不要忘记将最后一个切片加入到结果列表中
    slices.add(ScoreSlice(currentSliceEdits));
    for (var each in slices) {
      print(each.finalScores);
    }
    return slices;
  }
}
