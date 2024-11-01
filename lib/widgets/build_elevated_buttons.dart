import 'package:flutter/material.dart';

class BuildElevatedButtons extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget? child;
  final ButtonStyle? buttonStyle;
  final Text? text;
  final Color? color;

  const BuildElevatedButtons(
      {super.key,
      this.onPressed,
      this.child,
      this.buttonStyle,
      this.text,
      this.color});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: buttonStyle,
      child: child
    );
  }
}
