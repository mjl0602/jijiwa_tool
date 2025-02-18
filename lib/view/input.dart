// 输入框
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jijiwa_tool/style/color.dart';
import 'package:jijiwa_tool/style/size.dart';
import 'package:jijiwa_tool/style/text.dart';
import 'package:jijiwa_tool/tools/input_helper.dart';
import 'package:tapped/tapped.dart';

class StInput extends StatefulWidget {
  final TextEditingController? controller;
  final String? hintText;
  final bool enabled;
  final bool isPassword;
  final bool border;
  final bool onlyNumber;
  final int maxLength;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onSubmitted;
  final TextInputType? inputType;
  final FocusNode? focusNode;
  final TextAlign textAlign;
  final EdgeInsets? contentPadding;
  final bool? clearable;
  final bool? autofocus;
  final TextStyle? style;

  const StInput({
    Key? key,
    this.controller,
    this.hintText,
    this.enabled = true,
    this.isPassword = false,
    this.textInputAction,
    this.onSubmitted,
    this.focusNode,
    this.inputType,
    this.maxLength = 64,
    this.textAlign = TextAlign.start,
    this.onlyNumber = false,
    this.contentPadding,
    this.clearable,
    this.autofocus,
    this.style,
    this.border = false,
  }) : super(key: key);

  StInput.helper({
    Key? key,
    InputHelper? helper,
    this.hintText,
    this.enabled = true,
    this.isPassword = false,
    this.textInputAction,
    this.onSubmitted,
    this.inputType,
    this.maxLength = 64,
    this.textAlign = TextAlign.start,
    this.onlyNumber = false,
    this.contentPadding,
    this.clearable,
    this.autofocus,
    this.style,
    this.border = false,
  })  : this.controller = helper?.controller,
        this.focusNode = helper?.focusNode,
        super(key: key);

  @override
  _StInputState createState() => _StInputState();
}

class _StInputState extends State<StInput> {
  bool get hasClearBtn =>
      widget.controller?.text.isNotEmpty == true &&
      widget.focusNode?.hasFocus == true &&
      (widget.clearable ?? false);

  @override
  void initState() {
    super.initState();
    widget.controller?.addListener(update);
  }

  void update() => setState(() {});

  @override
  void dispose() {
    widget.controller?.removeListener(update);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: widget.border
            ? Border(
                bottom: BorderSide(
                  color: ColorPalette.halfGray,
                ),
              )
            : null,
      ),
      child: TextField(
        focusNode: widget.focusNode,
        controller: widget.controller,
        enabled: widget.enabled,
        style: widget.style,
        obscureText: widget.isPassword,
        keyboardType: widget.inputType,
        autofocus: widget.autofocus ?? false,
        keyboardAppearance: Brightness.light,
        textInputAction: widget.textInputAction,
        textAlign: widget.textAlign,
        inputFormatters: <TextInputFormatter>[
              widget.maxLength == 0
                  ? LengthLimitingTextInputFormatter(999)
                  : LengthLimitingTextInputFormatter(widget.maxLength), //限制长度
            ] +
            (widget.onlyNumber
                ? [
                    FilteringTextInputFormatter.allow(RegExp("[0-9]")),
                  ]
                : []),
        onSubmitted: widget.onSubmitted,
        decoration: InputDecoration(
          isDense: true,
          hintText: widget.hintText ?? '##Hint Text##',
          contentPadding: widget.contentPadding ??
              EdgeInsets.symmetric(
                horizontal: 6,
                vertical: 8,
              ),
          border: InputBorder.none,
          suffixIconConstraints: BoxConstraints(
            minHeight: 26,
          ),
          suffixIcon: hasClearBtn == true
              ? Tapped(
                  onTap: () {
                    if (widget.controller != null) {
                      widget.controller!.text = '';
                    }
                  },
                  child: Container(
                    margin: EdgeInsets.only(right: 2),
                    color: ColorPalette.clear,
                    padding: EdgeInsets.symmetric(
                      horizontal: 8,
                    ),
                    child: Icon(
                      Icons.cancel,
                      color: ColorPalette.gray,
                      size: 20,
                    ),
                  ),
                )
              : null,
          hintStyle: TextStyle(
            height: oneLineH,
            fontSize: SysSize.normal,
            color: ColorPalette.gray,
          ).merge(widget.style),
        ),
      ),
    );
  }
}

class StPwInput extends StatefulWidget {
  final TextEditingController? controller;
  final String? hintText;
  final bool enabled;
  final int maxLength;
  final bool onlyNumAndEn;
  final bool border;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onSubmitted;
  final FocusNode? focusNode;
  final TextInputType? inputType;
  final EdgeInsets? contentPadding;

  const StPwInput({
    Key? key,
    this.controller,
    this.hintText,
    this.enabled = true,
    this.textInputAction,
    this.onSubmitted,
    this.focusNode,
    this.inputType,
    this.onlyNumAndEn = false,
    this.maxLength = 64,
    this.contentPadding,
    this.border = false,
  }) : super(key: key);

  @override
  _StPwInputState createState() => _StPwInputState();
}

class _StPwInputState extends State<StPwInput> {
  bool showPassword = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: widget.border
            ? Border(
                bottom: BorderSide(
                  color: ColorPalette.halfGray,
                ),
              )
            : null,
      ),
      child: Stack(
        alignment: Alignment.centerRight,
        children: <Widget>[
          TextField(
            focusNode: widget.focusNode,
            controller: widget.controller,
            enabled: widget.enabled,
            obscureText: !showPassword,
            keyboardAppearance: Brightness.light,
            keyboardType: widget.inputType,
            textInputAction: widget.textInputAction,
            onSubmitted: widget.onSubmitted,
            inputFormatters: <TextInputFormatter>[
                  // WhitelistingTextInputFormatter.digitsOnly, //只输入数字
                  widget.maxLength == 0
                      ? LengthLimitingTextInputFormatter(999)
                      : LengthLimitingTextInputFormatter(
                          widget.maxLength), //限制长度
                ] +
                (widget.onlyNumAndEn
                    ? [
                        FilteringTextInputFormatter.allow(
                            RegExp("[a-zA-Z0-9]")),
                      ]
                    : []),
            decoration: InputDecoration(
              isDense: true,
              hintText: widget.hintText ?? '##Hint Text##',
              contentPadding: widget.contentPadding ??
                  EdgeInsets.symmetric(
                    horizontal: 6,
                  ),
              border: InputBorder.none,
              hintStyle: TextStyle(
                fontSize: 16,
                color: ColorPalette.gray,
              ),
            ),
          ),
          Tapped(
            onTap: () {
              setState(() => showPassword = !showPassword);
            },
            child: Container(
              height: 40,
              width: 40,
              color: ColorPalette.clear,
              child: Center(
                child: Icon(
                  Icons.remove_red_eye,
                  color: showPassword
                      ? ColorPalette.mainGreen
                      : ColorPalette.gray.withOpacity(0.5),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class StTextField extends StatelessWidget {
  final InputHelper? helper;
  final String? hintText;
  final bool? autofocus;
  final int? max;
  final int? minLines;
  final int? maxLines;
  final EdgeInsets? margin;
  const StTextField({
    Key? key,
    this.helper,
    this.hintText,
    this.margin,
    this.autofocus,
    this.max = 900,
    this.minLines,
    this.maxLines,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ?? EdgeInsets.fromLTRB(12, 10, 12, 8),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(6),
        child: Container(
          color: ColorPalette.lightBlueGray,
          child: TextField(
            focusNode: helper?.focusNode,
            controller: helper?.controller,
            autofocus: autofocus == true,
            keyboardAppearance: Brightness.light,
            minLines: minLines ?? 3,
            maxLines: maxLines ?? 20,
            keyboardType: TextInputType.multiline,
            inputFormatters: [
              LengthLimitingTextInputFormatter(max),
            ],
            decoration: InputDecoration(
              isDense: true,
              hintText: hintText ?? '',
              contentPadding: EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 8,
              ),
              border: InputBorder.none,
              hintStyle: TextStyle(
                height: oneLineH,
                fontSize: SysSize.normal,
                color: ColorPalette.gray,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
