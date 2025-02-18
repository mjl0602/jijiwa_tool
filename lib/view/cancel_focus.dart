import 'package:flutter/material.dart';

class TapToCancelFocus extends StatelessWidget {
  final Widget? child;

  const TapToCancelFocus({Key? key, this.child}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapUp: (d) {
        FocusScope.of(context).unfocus();
      },
      child: child,
    );
  }
}
