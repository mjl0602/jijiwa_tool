import 'package:flutter/material.dart';
import 'package:jijiwa_tool/database/player.dart';
import 'package:jijiwa_tool/db_service/game_room.dart';
import 'package:jijiwa_tool/global/data_base.dart';
import 'package:jijiwa_tool/style/color.dart';
import 'package:jijiwa_tool/style/text.dart';
import 'package:jijiwa_tool/tools/input_helper.dart';
import 'package:jijiwa_tool/view/cancel_focus.dart';
import 'package:jijiwa_tool/view/input.dart';
import 'package:jijiwa_tool/view/tap_button.dart';

class PlayerEditSheet extends StatefulWidget {
  const PlayerEditSheet({
    super.key,
    required this.player,
    required this.quickPickPlayers,
  });

  final Player player;
  final List<Player> quickPickPlayers;

  static Future<Player?> show(
    BuildContext context,
    Player player,
    List<Player> quickPickPlayers,
  ) async {
    final result = await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: ColorPalette.clear,
      builder: (ctx) => Container(
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Container(
                height: MediaQuery.of(context).size.height * 0.25,
                color: ColorPalette.clear,
              ),
            ),
            Expanded(
              child: PlayerEditSheet(
                player: player,
                quickPickPlayers: quickPickPlayers,
              ),
            ),
          ],
        ),
      ),
    );
    if (result is! Player) return null;
    return result;
  }

  @override
  State<PlayerEditSheet> createState() => _PlayerEditSheetState();
}

class _PlayerEditSheetState extends State<PlayerEditSheet> {
  late Color color = Color(widget.player.color);

  late String? emoji = widget.player.emoji;

  late InputHelper name = InputHelper(
    defaultText: widget.player.name,
  );

  late List<Player> quickPickPlayers = widget.quickPickPlayers;

  @override
  Widget build(BuildContext context) {
    return TapToCancelFocus(
      child: Container(
        color: ColorPalette.white,
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).padding.bottom,
        ),
        child: Container(
          padding: EdgeInsets.symmetric(
            vertical: 6,
          ),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 12,
                ),
                child: Row(
                  children: [
                    CanTap(
                      onTap: () {
                        setState(() {
                          color = ([...GameRoom.colorList]..shuffle()).first;
                          emoji = ([...GameRoom.emojiList]..shuffle()).first;
                        });
                      },
                      child: Container(
                        height: 60,
                        margin: EdgeInsets.only(right: 12),
                        decoration: BoxDecoration(
                          color: color,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: AspectRatio(
                          aspectRatio: 1,
                          child: Center(
                            child: StText.medium(
                              emoji,
                              style: TextStyle(
                                fontSize: 32,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        height: 60,
                        decoration: BoxDecoration(
                          color: ColorPalette.lightGray,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: StInput.helper(
                            helper: name,
                            hintText: '输入名字',
                            contentPadding: EdgeInsets.symmetric(
                              vertical: 12,
                              horizontal: 22,
                            ),
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    CanTap(
                      onTap: () {
                        widget.player.name = name.text;
                        widget.player.emoji = emoji;
                        widget.player.color = color.value;
                        Navigator.of(context).pop(widget.player);
                      },
                      child: Container(
                        height: 60,
                        margin: EdgeInsets.only(left: 12),
                        decoration: BoxDecoration(
                          color: ColorPalette.green,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: AspectRatio(
                          aspectRatio: 1.5,
                          child: Center(
                            child: Icon(
                              Icons.check,
                              color: ColorPalette.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              if (quickPickPlayers.isEmpty)
                Container(
                  height: 6,
                  width: double.infinity,
                  color: ColorPalette.lightGray,
                ),
              if (quickPickPlayers.isNotEmpty)
                Container(
                  height: 30,
                  child: ListView.builder(
                    padding: EdgeInsets.symmetric(
                      horizontal: 6,
                    ),
                    scrollDirection: Axis.horizontal,
                    itemCount: quickPickPlayers.length,
                    itemBuilder: (context, index) {
                      final _p = quickPickPlayers[index];
                      return CanTap(
                        onTap: () {
                          setState(() {
                            name.text = _p.name;
                            emoji = _p.emoji;
                            color = Color(_p.color);
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.only(
                            left: 10,
                            bottom: 2,
                            top: 2,
                          ),
                          margin: EdgeInsets.symmetric(
                            horizontal: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Color(_p.color),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Row(
                            children: [
                              Container(
                                padding: EdgeInsets.only(right: 6),
                                child: StText.small(_p.emoji),
                              ),
                              StText.small(
                                _p.name,
                                style: TextStyle(
                                  color: ColorPalette.white,
                                  height: oneLineH,
                                ),
                              ),
                              CanTap(
                                onTap: () async {
                                  await isar.writeTxn(() async {
                                    await isar.players.delete(_p.id);
                                  });
                                  setState(() {
                                    quickPickPlayers.remove(_p);
                                  });
                                },
                                child: Container(
                                  // color: ColorPalette.white,
                                  padding: EdgeInsets.fromLTRB(8, 4, 8, 4),
                                  child: Icon(
                                    Icons.close,
                                    size: 14,
                                    color: ColorPalette.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              Container(
                width: double.infinity,
                margin: EdgeInsets.only(top: 8),
                padding: EdgeInsets.symmetric(
                  horizontal: 8,
                ),
                child: Wrap(
                  children: GameRoom.colorList
                      .map(
                        (_color) => CanTap(
                          onTap: () {
                            setState(() {
                              color = _color;
                            });
                          },
                          child: FractionallySizedBox(
                            widthFactor: 1 / 8,
                            child: Container(
                              decoration: BoxDecoration(
                                color: _color,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              margin: EdgeInsets.all(4),
                              child: AspectRatio(
                                aspectRatio: 1,
                                child: color.value == _color.value
                                    ? Icon(
                                        Icons.check,
                                        color: ColorPalette.white,
                                      )
                                    : Container(),
                              ),
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
              Expanded(
                child: ListView(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      child: Wrap(
                        children: GameRoom.emojiList
                            .map(
                              (_emoji) => CanTap(
                                onTap: () {
                                  setState(() {
                                    emoji = _emoji;
                                  });
                                },
                                child: FractionallySizedBox(
                                  widthFactor: 1 / 6,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: color,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    margin: EdgeInsets.all(4),
                                    child: Stack(
                                      children: [
                                        AspectRatio(
                                          aspectRatio: 1,
                                          child: Center(
                                            child: StText.medium(
                                              _emoji,
                                              style: TextStyle(
                                                fontSize: 32,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                            right: 4,
                                            bottom: 4,
                                            child: emoji == _emoji
                                                ? Icon(
                                                    Icons.check,
                                                    color: ColorPalette.white,
                                                    size: 16,
                                                  )
                                                : Container())
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
