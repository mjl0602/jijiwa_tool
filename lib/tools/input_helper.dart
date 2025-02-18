import 'package:flutter/material.dart';

/// 封装了取值，焦点，控制器方法
class InputHelper {
  final String? defaultText;

  InputHelper({this.defaultText})
      : controller = TextEditingController(text: defaultText);

  final TextEditingController controller;

  String get text => controller.value.text;

  set text(String? t) {
    controller.value = TextEditingValue(text: t ?? '');
  }

  final FocusNode focusNode = FocusNode();
}
