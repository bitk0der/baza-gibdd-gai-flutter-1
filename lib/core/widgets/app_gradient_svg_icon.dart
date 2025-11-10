import 'package:baza_gibdd_gai/gen/assets.gen.dart';
import 'package:flutter/material.dart';

class AppGradientSvgIcon extends StatelessWidget {
  final List<Color> gradient;
  final SvgGenImage icon;
  final Alignment beginAlignment;
  final Alignment endAlignment;
  const AppGradientSvgIcon({
    super.key,
    required this.gradient,
    required this.icon,
    this.beginAlignment = Alignment.topCenter,
    this.endAlignment = Alignment.bottomCenter,
  });

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
        shaderCallback: (Rect bounds) {
          return LinearGradient(
            colors: gradient,
            begin: beginAlignment,
            end: endAlignment,
          ).createShader(bounds);
        },
        blendMode: BlendMode.srcATop,
        child: icon.svg());
  }
}
