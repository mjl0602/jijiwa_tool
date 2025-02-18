import 'dart:io';

import 'package:jijiwa_tool/global/user_default.dart';

import 'color.dart';
import 'size.dart';
import 'package:flutter/material.dart';

/// 为了让文字居中显示
double get oneLineH => Platform.isIOS ? 1.3 : 1.25;

class StandardTextStyle {
  static const TextStyle big = TextStyle(
    // fontFamily: 'MyraidPro',
    fontWeight: FontWeight.w600,
    fontSize: SysSize.big,
    color: ColorPalette.darkGray,
    inherit: true,
    height: 1.4,
  );
  static const TextStyle normalW = TextStyle(
    // fontFamily: 'MyraidPro',
    fontWeight: FontWeight.w600,
    fontSize: SysSize.normal,
    color: ColorPalette.darkGray,
    inherit: true,
    height: 1.4,
  );
  static const TextStyle normal = TextStyle(
    // fontFamily: 'MyraidPro',
    fontWeight: FontWeight.normal,
    fontSize: SysSize.normal,
    color: ColorPalette.darkGray,
    inherit: true,
    height: 1.4,
  );
  static const TextStyle small = TextStyle(
    // fontFamily: 'MyraidPro',
    fontWeight: FontWeight.normal,
    fontSize: SysSize.small,
    color: ColorPalette.halfGray,
    inherit: true,
    height: 1.4,
  );
}

class StText extends StatelessWidget {
  final String? text;
  final TextStyle? style;
  final TextStyle defaultStyle;
  final TextAlign? align;
  final int? maxLines;

  const StText({
    Key? key,
    this.text,
    this.style,
    required this.defaultStyle,
    this.maxLines,
    this.align,
  }) : super(key: key);

  const StText.small(
    String? text, {
    Key? key,
    TextStyle? style,
    TextAlign? align,
    int? maxLines,
  }) : this(
          key: key,
          text: text,
          style: style,
          defaultStyle: StandardTextStyle.small,
          maxLines: maxLines,
          align: align,
        );

  const StText.normal(
    String? text, {
    Key? key,
    TextStyle? style,
    TextAlign? align,
    int? maxLines,
  }) : this(
          key: key,
          text: text,
          style: style,
          defaultStyle: StandardTextStyle.normal,
          maxLines: maxLines,
          align: align,
        );

  const StText.medium(
    String? text, {
    Key? key,
    TextStyle? style,
    TextAlign? align,
    int? maxLines,
  }) : this(
          key: key,
          text: text,
          style: style,
          align: align,
          defaultStyle: StandardTextStyle.normalW,
          maxLines: maxLines,
        );

  const StText.big(
    String? text, {
    Key? key,
    TextStyle? style,
    TextAlign? align,
    int? maxLines,
  }) : this(
          key: key,
          text: text,
          style: style,
          defaultStyle: StandardTextStyle.big,
          maxLines: maxLines,
          align: align,
        );

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: defaultStyle,
      child: Text(
        text ?? '',
        maxLines: maxLines ?? 20,
        textAlign: align,
        textScaleFactor: TextScaleFactorListener.sizeScale.value / 10,
        overflow: TextOverflow.ellipsis,
        style: style,
      ),
    );
  }
}

class TextScaleFactorListener extends StatefulWidget {
  /// 缩放等级：10 = 缩放1.0 12 = 1.2倍放大
  static ValueNotifier<int> sizeScale = ValueNotifier<int>(10);

  final Widget child;

  const TextScaleFactorListener({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  State<TextScaleFactorListener> createState() =>
      _TextScaleFactorListenerState();
}

class _TextScaleFactorListenerState extends State<TextScaleFactorListener> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      var defaultValue = MediaQuery.of(context).textScaleFactor / 0.8 * 10 ~/ 1;
      if (UserDefault.fontSize.value == null) {
        UserDefault.fontSize.value = defaultValue;
      }
      TextScaleFactorListener.sizeScale.value =
          UserDefault.fontSize.value ?? 10;
    });
    TextScaleFactorListener.sizeScale.addListener(_update);
  }

  _update() {
    UserDefault.fontSize.value = TextScaleFactorListener.sizeScale.value;
    _rebuildAllChildren(context);
  }

  void _rebuildAllChildren(BuildContext context) {
    (context as Element).visitChildElements((e) {
      e.markNeedsBuild();
    });
  }

  @override
  void didUpdateWidget(covariant TextScaleFactorListener oldWidget) {
    super.didUpdateWidget(oldWidget);
    setState(() {});
  }

  @override
  void dispose() {
    TextScaleFactorListener.sizeScale.addListener(_update);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
