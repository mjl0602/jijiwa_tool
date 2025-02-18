import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CanTap extends StatefulWidget {
  const CanTap({
    super.key,
    this.onTap,
    required this.child,
    this.onLongTap,
  });

  final Function? onTap;
  final Function? onLongTap;
  final Widget child;

  @override
  State<CanTap> createState() => _CanTapState();
}

class _CanTapState extends State<CanTap> {
  double opacity = 1;
  Duration duration = Duration(milliseconds: 330);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        widget.onLongTap?.call();
      },
      onTap: () {
        widget.onTap?.call();
      },
      onTapDown: (d) {
        HapticFeedback.selectionClick();
        setState(() {
          duration = Duration.zero;
          opacity = 0.3;
        });
      },
      onTapUp: (d) {
        setState(() {
          duration = Duration.zero;
          opacity = 0.3;
        });
        WidgetsBinding.instance.addPostFrameCallback((t) {
          setState(() {
            duration = Duration(milliseconds: 330);
            opacity = 1;
          });
        });
      },
      onTapCancel: () {
        setState(() {
          duration = Duration(milliseconds: 330);
          opacity = 1;
        });
      },
      child: AnimatedOpacity(
        opacity: opacity,
        duration: duration,
        curve: Curves.easeInOutCubic,
        child: Container(
          color: Color(0),
          child: widget.child,
        ),
      ),
    );
  }
}
