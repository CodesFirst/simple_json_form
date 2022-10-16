import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    Key? key,
    required this.onPressed,
    required this.text,
    this.alignment,
    this.height = 50,
    this.width = double.infinity,
    this.radius = 10,
    this.textStyle,
    this.buttonColor,
    this.elevation,
    this.overflow,
  }) : super(key: key);

  final void Function() onPressed;
  final String text;
  final TextStyle? textStyle;
  final AlignmentGeometry? alignment;
  final double height;
  final double width;
  final double radius;
  final Color? buttonColor;
  final double? elevation;
  final TextOverflow? overflow;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        primary: buttonColor ?? Theme.of(context).primaryColor,
        backgroundColor: Colors.white,
        minimumSize: Size(width, height),
        side: BorderSide(color: Theme.of(context).primaryColor),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        alignment: alignment,
        elevation: elevation,
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.normal,
        ).merge(textStyle),
        textAlign: TextAlign.center,
        overflow: overflow,
      ),
    );
  }
}
