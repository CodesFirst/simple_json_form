import 'package:flutter/material.dart';

class TextCFirst extends StatelessWidget {
  const TextCFirst(this.text,
      {Key? key,
      this.fontSize = 12,
      this.fontWeight = FontWeight.normal,
      this.fontFamily,
      this.colorText = const Color(0xff242424)})
      : super(key: key);

  final String text;
  final double fontSize;
  final FontWeight fontWeight;
  final Color colorText;
  final String? fontFamily;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: colorText,
        fontSize: fontSize,
        fontWeight: fontWeight,
        fontFamily: fontFamily,
      ),
    );
  }
}
