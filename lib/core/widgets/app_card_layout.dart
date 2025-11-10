import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Опционально: вынесем дефолтные тени в константы.
const _kDefaultShadowOpacity = 0.15;

class AppCardLayout extends StatelessWidget {
  final Widget child;
  final Color? color;
  final EdgeInsetsGeometry? padding;
  final double? radius;
  final double? height;
  final double? width;
  final BoxBorder? border;
  final bool isNeedShadow;
  final BoxShadow? shadow;
  final VoidCallback? onTap;
  final String? backgroundImage;
  final List<Color>? gradient;
  final BorderRadiusGeometry? borderRadius;
  final List<Color>? gradientBorder;
  final double blur;
  final Alignment beginAlignment;
  final Alignment endAlignment;
  final bool isVisible;

  const AppCardLayout({
    required this.child,
    this.border,
    this.isNeedShadow = false,
    this.radius,
    this.width,
    this.padding,
    this.color,
    this.backgroundImage,
    this.height,
    this.shadow,
    this.gradient,
    super.key,
    this.onTap,
    this.borderRadius,
    this.gradientBorder,
    this.blur = 0,
    this.beginAlignment = Alignment.centerLeft,
    this.endAlignment = Alignment.centerRight,
    this.isVisible = true,
  });

  @override
  Widget build(BuildContext context) {
    if (!isVisible) return const SizedBox.shrink();

    final double r = (radius ?? 20.r);
    final BorderRadiusGeometry br = borderRadius ?? BorderRadius.circular(r);
    final double strokeWidth = gradientBorder != null ? 1.0 : 0.0;

    Widget content = _CardChild(
      padding: padding ?? EdgeInsets.all(14.r),
      height: height,
      width: width,
      color: color,
      border: border,
      beginAlignment: beginAlignment,
      endAlignment: endAlignment,
      gradient: gradient,
      backgroundImage: backgroundImage,
      borderRadius: br,
      isNeedShadow: isNeedShadow,
      shadow: shadow,
      child: child,
    );

    // Если blur > 0 — применяем ClipRRect + BackdropFilter.
    if (blur > 0) {
      content = ClipRRect(
        borderRadius: br,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
          child: content,
        ),
      );
    }

    // Если есть градиентная рамка — рисуем один слой CustomPaint + паддинг=strokeWidth.
    if (gradientBorder != null) {
      content = CustomPaint(
        painter: GradientBorderPainter(
          radius: r,
          colors: gradientBorder!,
          begin: beginAlignment,
          end: endAlignment,
          strokeWidth: strokeWidth,
          borderRadius: br,
        ),
        child: Padding(padding: EdgeInsets.all(strokeWidth), child: content),
      );
    }

    // RepaintBoundary уменьшает область перерисовки дочерних виджетов.
    final body = RepaintBoundary(child: content);

    // GestureDetector оборачиваем последним слоем.
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: body,
    );
  }
}

class _CardChild extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final double? height;
  final double? width;
  final Color? color;
  final BoxBorder? border;
  final List<Color>? gradient;
  final String? backgroundImage;
  final BorderRadiusGeometry borderRadius;
  final bool isNeedShadow;
  final BoxShadow? shadow;
  final Alignment beginAlignment;
  final Alignment endAlignment;

  const _CardChild({
    required this.child,
    required this.padding,
    required this.borderRadius,
    required this.beginAlignment,
    required this.endAlignment,
    this.height,
    this.width,
    this.color,
    this.border,
    this.gradient,
    this.backgroundImage,
    this.isNeedShadow = false,
    this.shadow,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
      padding: padding,
      height: height,
      width: width,
      decoration: BoxDecoration(
        boxShadow: isNeedShadow
            ? <BoxShadow>[
                shadow ??
                    BoxShadow(
                      color: Colors.black.withValues(
                        alpha: _kDefaultShadowOpacity,
                      ),
                      blurRadius: 10.r,
                    ),
              ]
            : null,
        border: border,
        gradient: gradient == null
            ? null
            : LinearGradient(
                colors: gradient!,
                begin: beginAlignment,
                end: endAlignment,
              ),
        color: gradient == null ? (color ?? Colors.white) : null,
        image: backgroundImage != null
            ? DecorationImage(
                image: AssetImage(backgroundImage!),
                fit: BoxFit.cover,
                alignment: Alignment.bottomCenter,
              )
            : null,
        borderRadius: borderRadius,
      ),
      child: child,
    );
  }
}

class GradientBorderPainter extends CustomPainter {
  final double radius;
  final List<Color> colors;
  final double strokeWidth;
  final Alignment begin;
  final Alignment end;
  final BorderRadiusGeometry borderRadius;

  GradientBorderPainter({
    required this.radius,
    required this.colors,
    required this.borderRadius,
    this.strokeWidth = 1.0,
    this.begin = Alignment.centerLeft,
    this.end = Alignment.centerRight,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (strokeWidth <= 0) return;

    final Rect rect = Offset.zero & size;
    final Gradient gradient = LinearGradient(
      colors: colors,
      begin: begin,
      end: end,
    );

    // Внутренний прямоугольник с учётом половины толщины штриха.
    final RRect outer = RRect.fromRectAndCorners(
      rect,
      topLeft: (borderRadius.resolve(TextDirection.ltr).topLeft),
      topRight: (borderRadius.resolve(TextDirection.ltr).topRight),
      bottomLeft: (borderRadius.resolve(TextDirection.ltr).bottomLeft),
      bottomRight: (borderRadius.resolve(TextDirection.ltr).bottomRight),
    );

    final RRect inner = outer.deflate(strokeWidth / 2);

    final Paint paint = Paint()
      ..shader = gradient.createShader(rect)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeJoin = StrokeJoin.round;

    canvas.drawRRect(inner, paint);
  }

  @override
  bool shouldRepaint(covariant GradientBorderPainter old) {
    return old.radius != radius ||
        old.strokeWidth != strokeWidth ||
        old.begin != begin ||
        old.end != end ||
        old.borderRadius != borderRadius ||
        !_listEquals(old.colors, colors);
  }

  bool _listEquals(List<Color> a, List<Color> b) {
    if (identical(a, b)) return true;
    if (a.length != b.length) return false;
    for (int i = 0; i < a.length; i++) {
      if (a[i] != b[i]) return false;
    }
    return true;
  }
}
