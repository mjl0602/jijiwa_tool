import 'package:flutter/material.dart';
import 'package:jijiwa_tool/database/player.dart';
import 'package:jijiwa_tool/db_service/game_room.dart';
import 'package:jijiwa_tool/global/data_base.dart';
import 'package:jijiwa_tool/pages/player_edit_sheet.dart';
import 'package:jijiwa_tool/style/color.dart';
import 'package:jijiwa_tool/style/text.dart';
import 'package:jijiwa_tool/view/tap_button.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GameRoom gameRoom = GameRoom();

  Set<int> expandRow = Set();

  double get rowHeight =>
      ((MediaQuery.of(context).size.height - 220) / gameRoom.players.length)
          .clamp(74, 200);

  @override
  void initState() {
    super.initState();
    gameRoom.addListener(_updateIfRoomChange);
    gameRoom.startGame();
  }

  _updateIfRoomChange() {
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    gameRoom.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: StText.big('🌲叽叽蛙记分'),
        actions: [
          IconButton(
            icon: Icon(Icons.more_horiz),
            onPressed: () {
              gameRoom.startGame();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                for (final player in gameRoom.players) //
                  _PlayerRow(
                    height: rowHeight,
                    player: player,
                    isExpand: expandRow.contains(player.id),
                    onExpand: () {
                      setState(() {
                        if (expandRow.contains(player.id)) {
                          expandRow.remove(player.id);
                        } else {
                          expandRow.clear();
                          expandRow.add(player.id);
                        }
                      });
                    },
                    onEdit: (score, desc) {
                      gameRoom.putScore(player, score, desc);
                    },
                    onRemove: () async {
                      await gameRoom.removePlayer(player);
                    },
                    onTapPlayer: () async {
                      final newPlayerConfig =
                          await PlayerEditSheet.show(context, player);
                      if (newPlayerConfig == null) return;
                      await isar.writeTxn(() async {
                        await isar.players.put(player);
                      });
                      await gameRoom.reloadPlayers();
                    },
                  ),
                Container(
                  color: ColorPalette.white,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    child: Row(
                      children: [
                        CanTap(
                          onTap: () async {
                            await gameRoom.removePlayer();
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: ColorPalette.lightGray,
                              borderRadius: BorderRadius.horizontal(
                                left: Radius.circular(6),
                              ),
                              border: Border(
                                right: BorderSide(
                                  color: ColorPalette.halfGray.withOpacity(0.2),
                                ),
                              ),
                            ),
                            padding: EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 10,
                            ),
                            child: Center(
                              child: Icon(
                                Icons.person_off,
                                color: ColorPalette.gray,
                                size: 18,
                              ),
                            ),
                          ),
                        ),
                        CanTap(
                          onTap: () async {
                            await gameRoom.addPlayer();
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: ColorPalette.lightGray,
                              borderRadius: BorderRadius.horizontal(
                                right: Radius.circular(6),
                              ),
                              border: Border(
                                left: BorderSide(
                                  color: ColorPalette.halfGray.withOpacity(0.2),
                                ),
                              ),
                            ),
                            padding: EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 10,
                            ),
                            child: Center(
                              child: Icon(
                                Icons.person_add,
                                color: ColorPalette.gray,
                                size: 18,
                              ),
                            ),
                          ),
                        ),
                        Spacer(),
                        CanTap(
                          onTap: () {},
                          child: Container(
                            decoration: BoxDecoration(
                              color: ColorPalette.lightGray,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            padding: EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 10,
                            ),
                            child: Center(
                              child: Icon(
                                Icons.undo,
                                color: ColorPalette.gray,
                                size: 18,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            color: ColorPalette.white,
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).padding.bottom,
            ),
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 8,
              ),
              child: Row(
                children: [
                  CanTap(
                    onTap: () async {
                      await gameRoom.undo();
                    },
                    child: Container(
                      height: 52,
                      decoration: BoxDecoration(
                        color: ColorPalette.lightGray,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: 24,
                      ),
                      child: Center(
                        child: Icon(
                          Icons.undo,
                          color: ColorPalette.gray,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 10,
                  ),
                  CanTap(
                    onTap: () async {
                      await gameRoom.setRandomUserConfig();
                    },
                    child: Container(
                      height: 52,
                      decoration: BoxDecoration(
                        color: ColorPalette.lightGray,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: 18,
                      ),
                      child: Center(
                        child: StText.big(
                          '🎲',
                          style: TextStyle(
                            fontSize: 32,
                            height: 1.1,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Spacer(),
                  CanTap(
                    onTap: () async {
                      gameRoom.restart();
                    },
                    child: Container(
                      height: 52,
                      decoration: BoxDecoration(
                        color: ColorPalette.green,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: AspectRatio(
                        aspectRatio: 2,
                        child: Center(
                          child: Icon(
                            Icons.refresh,
                            color: ColorPalette.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _PlayerRow extends StatelessWidget {
  const _PlayerRow({
    super.key,
    required this.player,
    required this.onEdit,
    required this.isExpand,
    required this.onExpand,
    required this.onTapPlayer,
    required this.height,
    required this.onRemove,
  });

  final Player player;
  final double height;
  final bool isExpand;
  final Function onExpand;
  final Function onRemove;
  final Function onTapPlayer;
  final Function(int score, String desc) onEdit;

  @override
  Widget build(BuildContext context) {
    var rowBody = GestureDetector(
      onTap: () => onExpand(),
      child: Container(
        height: height,
        color: ColorPalette.clear,
        child: Row(
          children: [
            CanTap(
              onTap: onTapPlayer,
              child: AspectRatio(
                aspectRatio: height > 150 ? 0.66 : 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    StText.big(
                      player.emoji,
                      style: TextStyle(
                        fontSize: height < 90 ? 36 : 50,
                        color: ColorPalette.white,
                      ),
                    ),
                    if (player.name?.isNotEmpty == true)
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        child: StText.medium(
                          player.name,
                          style: TextStyle(
                            fontSize: height < 90 ? 14 : 20,
                            color: ColorPalette.white,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
            Container(
              height: double.infinity,
              margin: EdgeInsets.symmetric(vertical: 22),
              width: 1,
              color: ColorPalette.white.withOpacity(.2),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 12,
                ),
                child: Row(
                  children: [
                    _BasicCalculateBtn(
                      onTap: () => onEdit(player.score - 1, '-1'),
                      child: Icon(
                        Icons.remove,
                        size: 16,
                        color: ColorPalette.white,
                      ),
                    ),
                    Expanded(
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            vertical: 4,
                          ),
                          child: StText.medium(
                            '${player.score}',
                            align: TextAlign.center,
                            style: TextStyle(
                              fontSize: 32,
                              color: ColorPalette.white,
                              height: 1.2,
                            ),
                          ),
                        ),
                      ),
                    ),
                    _BasicCalculateBtn(
                      onTap: () => onEdit(player.score + 1, '+1'),
                      child: Icon(
                        Icons.add,
                        size: 16,
                        color: ColorPalette.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
    return Container(
      decoration: BoxDecoration(
        color: Color(player.color),
        border: Border(
          bottom: BorderSide(
            color: ColorPalette.white.withOpacity(0.2),
          ),
        ),
      ),
      child: Column(
        children: [
          rowBody,
          ClipRect(
            child: AnimatedAlign(
              duration: Duration(
                milliseconds: 230,
              ),
              curve: Curves.easeInOutCubic,
              alignment: Alignment.bottomCenter,
              heightFactor: isExpand ? 1 : 0,
              child: AnimatedOpacity(
                duration: Duration(
                  milliseconds: 230,
                ),
                curve: Curves.easeInOutCubic,
                opacity: isExpand ? 1 : 0,
                child: Container(
                  padding: EdgeInsets.only(
                    right: 8,
                  ),
                  decoration: BoxDecoration(
                    color: ColorPalette.black.withOpacity(0.1),
                    // border: Border(
                    //   top: BorderSide(
                    //     color: ColorPalette.white.withOpacity(0.2),
                    //   ),
                    // ),
                  ),
                  child: Row(
                    children: [
                      CanTap(
                        onTap: onRemove,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          // color: ColorPalette.blue1,
                          child: Center(
                            child: Icon(
                              Icons.delete,
                              size: 20,
                              color: ColorPalette.white,
                            ),
                          ),
                        ),
                      ),
                      Spacer(),
                      _SmallCalculateBtn(
                        text: '-10',
                        onTap: () => onEdit(player.score - 10, '-10'),
                      ),
                      _SmallCalculateBtn(
                        text: '+10',
                        onTap: () => onEdit(player.score + 10, '+10'),
                      ),
                      _SmallCalculateBtn(
                        text: '×2',
                        onTap: () => onEdit(player.score * 2, '×2'),
                      ),
                      _SmallCalculateBtn(
                        text: '=0',
                        onTap: () => onEdit(0, '=0'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _BasicCalculateBtn extends StatelessWidget {
  const _BasicCalculateBtn({
    super.key,
    required this.child,
    required this.onTap,
  });

  final Widget child;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: 24,
      ),
      child: CanTap(
        onTap: onTap,
        child: Container(
          // color: ColorPalette.gray,
          child: Center(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(999),
                color: ColorPalette.white.withOpacity(0.2),
              ),
              margin: EdgeInsets.symmetric(
                horizontal: 10,
              ),
              padding: EdgeInsets.symmetric(
                vertical: 6,
                horizontal: 16,
              ),
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}

class _SmallCalculateBtn extends StatelessWidget {
  const _SmallCalculateBtn({
    super.key,
    required this.text,
    required this.onTap,
  });

  final String text;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return CanTap(
      onTap: onTap,
      child: Center(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: ColorPalette.white.withOpacity(0.2),
          ),
          margin: EdgeInsets.symmetric(
            horizontal: 4,
            vertical: 6,
          ),
          padding: EdgeInsets.symmetric(
            vertical: 2,
            horizontal: 16,
          ),
          child: StText.medium(
            text,
            style: TextStyle(
              color: ColorPalette.white,
              height: 1.3,
            ),
          ),
        ),
      ),
    );
  }
}
