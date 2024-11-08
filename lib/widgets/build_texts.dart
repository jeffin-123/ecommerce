import 'package:flutter/widgets.dart';

class BuildTexts extends StatelessWidget {
  final Color? color;
  final double? size;
  final TextStyle? textStyle;
  final String? texts;

  const BuildTexts(
      {super.key, this.color, this.size, this.textStyle, this.texts});

  @override
  Widget build(BuildContext context) {
    return Text(
      texts ?? " ",
      style: textStyle,

    );
  }
}
