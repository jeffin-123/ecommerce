import 'package:flutter/material.dart';

class BuildIconButtons extends StatelessWidget {
  final VoidCallback? onPressed;
  final Icon? icon;
  final ButtonStyle? buttonStyle;
  final Color? color;
  final double? size;

  const BuildIconButtons(
      {super.key,
      this.onPressed,
      this.icon,
      this.buttonStyle,
      this.color,
      this.size});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: icon ?? const Icon(Icons.arrow_back),
      style: buttonStyle,
      color: color,
      iconSize: size,
    );
  }
}
