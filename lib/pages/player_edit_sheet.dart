import 'package:flutter/material.dart';
import 'package:jijiwa_tool/database/player.dart';
import 'package:jijiwa_tool/db_service/game_room.dart';
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
  });

  final Player player;

  static Future<Player?> show(BuildContext context, Player player) async {
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
              child: PlayerEditSheet(player: player),
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
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      width: 6,
                      color: ColorPalette.lightGray,
                    ),
                  ),
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
