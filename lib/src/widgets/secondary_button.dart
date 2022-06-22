import 'package:flutter/material.dart';

class SecondaryButton extends StatelessWidget {
  const SecondaryButton({
    Key? key,
    required this.onPressed,
    required this.text,
    required this.iconWidget,
    this.textAlign,
    this.alignment,
    this.height = 50,
    this.width = double.infinity,
    this.radius = 10,
    this.textStyle,
    this.buttonColor,
  }) : super(key: key);

  final void Function() onPressed;
  final String text;
  final TextStyle? textStyle;
  final AlignmentGeometry? alignment;
  final double height;
  final double width;
  final double radius;
  final Color? buttonColor;
  final Widget iconWidget;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      icon: iconWidget,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        primary: buttonColor ?? Theme.of(context).primaryColor,
        minimumSize: Size(width, height),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius),
        ),
        alignment: alignment,
      ),
      onPressed: onPressed,
      label: Text(
        text,
        textAlign: textAlign,
        style: const TextStyle(fontWeight: FontWeight.w700).merge(textStyle),
      ),
    );
  }
}
