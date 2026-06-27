import 'package:flutter/material.dart';

class EonText extends StatelessWidget {
  final String text;
  final FontWeight? fontWeight;
  final double? fontSize;
  final double? letterSpacing;
  final Color? color;
  final int? withAlpha;
  final TextDecoration? decoration;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;

  const EonText(this.text, {super.key, this.fontWeight, this.fontSize, this.letterSpacing, this.color, this.withAlpha, this.decoration, this.textAlign, this.maxLines, this.overflow});
  const EonText.displayLarge(this.text, {super.key, this.fontWeight = FontWeight.w500, this.fontSize = 57, this.letterSpacing = -0.25, this.color, this.withAlpha, this.decoration, this.textAlign, this.maxLines, this.overflow});
  const EonText.displayMedium(this.text, {super.key, this.fontWeight = FontWeight.w500, this.fontSize = 45, this.letterSpacing = 0, this.color, this.withAlpha, this.decoration, this.textAlign, this.maxLines, this.overflow});
  const EonText.displaySmall(this.text, {super.key, this.fontWeight = FontWeight.w500, this.fontSize = 36, this.letterSpacing = 0, this.color, this.withAlpha, this.decoration, this.textAlign, this.maxLines, this.overflow});
  const EonText.headlineLarge(this.text, {super.key, this.fontWeight = FontWeight.w500, this.fontSize = 32, this.letterSpacing = -0.2, this.color, this.withAlpha, this.decoration, this.textAlign, this.maxLines, this.overflow});
  const EonText.headlineMedium(this.text, {super.key, this.fontWeight = FontWeight.w500, this.fontSize = 28, this.letterSpacing = -0.15, this.color, this.withAlpha, this.decoration, this.textAlign, this.maxLines, this.overflow});
  const EonText.headlineSmall(this.text, {super.key, this.fontWeight = FontWeight.w500, this.fontSize = 26, this.letterSpacing = 0, this.color, this.withAlpha, this.decoration, this.textAlign, this.maxLines, this.overflow});
  const EonText.titleLarge(this.text, {super.key, this.fontWeight = FontWeight.w500, this.fontSize = 22, this.letterSpacing = 0, this.color, this.withAlpha, this.decoration, this.textAlign, this.maxLines, this.overflow});
  const EonText.titleMedium(this.text, {super.key, this.fontWeight = FontWeight.w500, this.fontSize = 16, this.letterSpacing = 0.1, this.color, this.withAlpha, this.decoration, this.textAlign, this.maxLines, this.overflow});
  const EonText.titleSmall(this.text, {super.key, this.fontWeight = FontWeight.w500, this.fontSize = 14, this.letterSpacing = 0.1, this.color, this.withAlpha, this.decoration, this.textAlign, this.maxLines, this.overflow});
  const EonText.labelLarge(this.text, {super.key, this.fontWeight = FontWeight.w500, this.fontSize = 14, this.letterSpacing = 0.1, this.color, this.withAlpha, this.decoration, this.textAlign, this.maxLines, this.overflow});
  const EonText.labelMedium(this.text, {super.key, this.fontWeight = FontWeight.w500, this.fontSize = 12, this.letterSpacing = 0.5, this.color, this.withAlpha, this.decoration, this.textAlign, this.maxLines, this.overflow});
  const EonText.labelSmall(this.text, {super.key, this.fontWeight = FontWeight.w500, this.fontSize = 11, this.letterSpacing = 0.5, this.color, this.withAlpha, this.decoration, this.textAlign, this.maxLines, this.overflow});
  const EonText.bodyLarge(this.text, {super.key, this.fontWeight = FontWeight.w500, this.fontSize = 16, this.letterSpacing = 0.5, this.color, this.withAlpha, this.decoration, this.textAlign, this.maxLines, this.overflow});
  const EonText.bodyMedium(this.text, {super.key, this.fontWeight = FontWeight.w500, this.fontSize = 14, this.letterSpacing = 0.25, this.color, this.withAlpha, this.decoration, this.textAlign = TextAlign.center, this.maxLines, this.overflow});
  const EonText.bodySmall(this.text, {super.key, this.fontWeight = FontWeight.w500, this.fontSize = 12, this.letterSpacing = 0.4, this.color, this.withAlpha, this.decoration, this.textAlign, this.maxLines, this.overflow});
  @override
  Widget build(BuildContext context) {
    final Color baseColor = withAlpha != null ? Theme.of(context).colorScheme.onSurface.withAlpha(withAlpha!) : Theme.of(context).colorScheme.onSurface;
    return Text(
      text,
      style: TextStyle(wordSpacing: 0, fontWeight: fontWeight, fontSize: fontSize, letterSpacing: letterSpacing, color: color ?? baseColor, decoration: decoration),
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
    );
  }

  static TextStyle textStyle(BuildContext context, {double fontSize = 14, FontWeight fontWeight = FontWeight.w500, double letterSpacing = 0.25, Color? color, int? withAlpha, TextDecoration? decoration}) {
    final Color baseColor = withAlpha != null ? Theme.of(context).colorScheme.onSurface.withAlpha(withAlpha) : Theme.of(context).colorScheme.onSurface;
    return TextStyle(fontSize: fontSize, fontWeight: fontWeight, letterSpacing: letterSpacing, color: color ?? baseColor, decoration: decoration);
  }
}
