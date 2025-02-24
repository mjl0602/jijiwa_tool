import 'package:flutter/material.dart';
import 'package:jijiwa_tool/database/player.dart';
import 'package:jijiwa_tool/style/color.dart';
import 'package:jijiwa_tool/style/text.dart';
import 'package:jijiwa_tool/view/cancel_focus.dart';
import 'package:jijiwa_tool/view/tap_button.dart';

class KeyboardResult {
  final int score;
  final String description;

  KeyboardResult({required this.score, required this.description});
}

class KeyboardSheet extends StatefulWidget {
  const KeyboardSheet({
    super.key,
    required this.player,
    required this.defaultAction,
  });

  final Player player;
  final ActType? defaultAction;

  static Future<KeyboardResult?> show(
    BuildContext context,
    Player player,
    ActType action,
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
              child: KeyboardSheet(
                player: player,
                defaultAction: action,
              ),
            ),
          ],
        ),
      ),
    );
    if (result is! KeyboardResult) return null;
    return result;
  }

  @override
  State<KeyboardSheet> createState() => _KeyboardSheetState();
}

class _KeyboardSheetState extends State<KeyboardSheet> {
  String get actText => '${act.text}${score} ';
  late ActType act = widget.defaultAction?.isAct == true
      ? widget.defaultAction!
      : ActType.blank;
  String score = '';

  String get resultText => '=${resultScore}';
  int get resultScore {
    final v = int.tryParse(score) ?? 0;
    if (act == ActType.add) return widget.player.score + v;
    if (act == ActType.reduce) return widget.player.score - v;
    if (act == ActType.muti) return widget.player.score * v;
    if (act == ActType.divider) {
      if (v == 0) return widget.player.score;
      return widget.player.score ~/ v;
    }
    return widget.player.score;
  }

  submit() {
    if (score.isEmpty) {
      Navigator.of(context).maybePop();
      return;
    }
    if (resultScore == widget.player.score) {
      Navigator.of(context).maybePop();
      return;
    }
    Navigator.of(context).maybePop(KeyboardResult(
      score: resultScore,
      description: actText,
    ));
  }

  putScore(int? value) {
    if (!act.isAct) return;
    if (value == null) return;
    final _old = score;
    score += '${value}';
    final v = int.tryParse(score);
    if (v == null) {
      score = '';
    } else {
      if (v > 999999)
        score = _old;
      else
        score = v.clamp(0, 999999).toString();
    }
    setState(() {});
  }

  bool get scoreTooLong => '${widget.player.score}${score}'.length > 10;

  List<List<_BtnConfig>> get table => [
        [
          _BtnConfig.num(
            ActType._7,
            (type) => putScore(type.value),
          ),
          _BtnConfig.num(
            ActType._8,
            (type) => putScore(type.value),
          ),
          _BtnConfig.num(
            ActType._9,
            (type) => putScore(type.value),
          ),
          _BtnConfig.act(
            ActType.add,
            (type) => setState(() => act = type),
          ),
        ],
        [
          _BtnConfig.num(
            ActType._6,
            (type) => putScore(type.value),
          ),
          _BtnConfig.num(
            ActType._5,
            (type) => putScore(type.value),
          ),
          _BtnConfig.num(
            ActType._4,
            (type) => putScore(type.value),
          ),
          _BtnConfig.act(
            ActType.reduce,
            (type) => setState(() => act = type),
          ),
        ],
        [
          _BtnConfig.num(
            ActType._3,
            (type) => putScore(type.value),
          ),
          _BtnConfig.num(
            ActType._2,
            (type) => putScore(type.value),
          ),
          _BtnConfig.num(
            ActType._1,
            (type) => putScore(type.value),
          ),
          _BtnConfig.act(
            ActType.muti,
            (type) => setState(() => act = type),
          ),
        ],
        [
          _BtnConfig.num(
            ActType.clear,
            (type) {
              setState(() {
                act = ActType.blank;
                score = '';
              });
            },
          ),
          _BtnConfig.num(
            ActType._0,
            (type) => putScore(type.value),
          ),
          _BtnConfig.num(
            ActType.backspace,
            (type) {
              setState(() {
                if (score == '') {
                  act = ActType.blank;
                } else {
                  score = score.substring(0, score.length - 1);
                }
              });
            },
          ),
          _BtnConfig.act(
            ActType.divider,
            (type) => setState(() => act = type),
          ),
        ],
      ];

  @override
  Widget build(BuildContext context) {
    var playerRow = Container(
      width: MediaQuery.of(context).size.width,
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
          Container(
            height: 80,
            margin: EdgeInsets.only(right: 12),
            decoration: BoxDecoration(
              color: Color(widget.player.color),
              borderRadius: BorderRadius.circular(8),
            ),
            child: AspectRatio(
              aspectRatio: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  StText.big(
                    widget.player.emoji,
                    style: TextStyle(
                      fontSize: 36,
                      color: ColorPalette.white,
                    ),
                  ),
                  if (widget.player.name?.isNotEmpty == true)
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: StText.medium(
                        widget.player.name,
                        style: TextStyle(
                          fontSize: 14,
                          color: ColorPalette.white,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              right: 6,
              left: 6,
            ),
            child: StText.big(
              widget.player.score.toString(),
              style: TextStyle(
                fontSize: widget.player.score.toString().length > 4 ? 24 : 36,
              ),
            ),
          ),
          Expanded(
            child: FittedBox(
              fit: BoxFit.scaleDown,
              alignment: Alignment.centerLeft,
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 4,
                ),
                child: StText.big(
                  actText,
                  style: TextStyle(
                    fontSize: 36,
                    color: Color(widget.player.color),
                  ),
                ),
              ),
            ),
          ),
          CanTap(
            onTap: submit,
            child: Container(
              margin: EdgeInsets.only(left: 6),
              padding: EdgeInsets.symmetric(
                vertical: 14,
                horizontal: scoreTooLong ? 16 : 10,
              ),
              decoration: BoxDecoration(
                color: ColorPalette.green,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (!scoreTooLong)
                    Container(
                      padding: EdgeInsets.only(right: 6),
                      child: StText.big(
                        resultText,
                        style: TextStyle(
                          fontSize: 20,
                          color: ColorPalette.white,
                        ),
                      ),
                    ),
                  Container(
                    child: Icon(
                      Icons.check,
                      size: 24,
                      color: ColorPalette.white,
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
    var keyboard = Column(
      children: [
        for (final row in table)
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                children: [
                  for (final item in row)
                    Expanded(
                      flex: item.flex,
                      child: CanTap(
                        onTap: () {
                          item.onTap(item.type);
                        },
                        child: Container(
                          margin: EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: item.type.isAct
                                ? Color(widget.player.color).withOpacity(0.1)
                                : ColorPalette.lightGray,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          alignment: Alignment.center,
                          child: item.type.icon != null
                              ? Icon(
                                  item.type.icon,
                                  size: 32,
                                  color: Color(widget.player.color),
                                )
                              : StText.big(
                                  item.type.text,
                                  style: TextStyle(fontSize: 32),
                                ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          )
      ],
    );
    return TapToCancelFocus(
      child: Container(
        color: ColorPalette.white,
        width: double.infinity,
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).padding.bottom,
        ),
        child: Container(
          padding: EdgeInsets.symmetric(
            vertical: 6,
          ),
          child: Column(
            children: [
              playerRow,
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: keyboard,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

// 加减乘除和各种数字
enum ActType {
  add('+', true),
  reduce('-', true),
  muti('×', true),
  divider('÷', true),
  _1('1', false, 1),
  _2('2', false, 2),
  _3('3', false, 3),
  _4('4', false, 4),
  _5('5', false, 5),
  _6('6', false, 6),
  _7('7', false, 7),
  _8('8', false, 8),
  _9('9', false, 9),
  _0('0', false, 0),
  clear('C', true),
  backspace('<', true),
  blank('', false);

  final String text;
  final bool isAct;
  final int? value;

  IconData? get icon {
    if (this == ActType.clear) return Icons.cleaning_services_rounded;
    if (this == ActType.backspace) return Icons.backspace_rounded;
    return null;
  }

  const ActType(
    this.text,
    this.isAct, [
    this.value,
  ]);
}

class _BtnConfig {
  final ActType type;
  final int flex;
  final Function(ActType type) onTap;

  _BtnConfig._({
    required this.type,
    required this.flex,
    required this.onTap,
  });

  _BtnConfig.num(ActType type, Function(ActType type) onTap)
      : this._(
          flex: 10,
          type: type,
          onTap: onTap,
        );

  _BtnConfig.act(ActType type, Function(ActType type) onTap)
      : this._(
          flex: 10,
          type: type,
          onTap: onTap,
        );
}
