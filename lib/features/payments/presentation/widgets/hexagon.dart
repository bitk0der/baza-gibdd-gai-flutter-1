import 'package:flutter/material.dart';
import 'package:baza_gibdd_gai/gen/assets.gen.dart';

class Hexagon extends StatelessWidget {
  final Widget child;
  final double width;
  final double height;

  const Hexagon({
    super.key,
    required this.child,
    required this.width,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width + 2,
      height: height + 2,
      child: Stack(
        children: [
          Center(
            child: Assets.icons.hexagon.svg(
              width: width,
              height: height,
              alignment: Alignment.center,
            ),
          ),
          Center(child: child),
        ],
      ),
    );
  }
}
