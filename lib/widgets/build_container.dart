import 'package:flutter/widgets.dart';

class BuildContainer extends StatelessWidget {
  final Widget? child;
  final double? height;
  final double? width;
  final String? text;
  final Decoration? decoration;

  const BuildContainer(
      {super.key,
      this.child,
      this.height,
      this.width,
      this.text,
      this.decoration});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: decoration,
      child: child,
    );
  }
}
