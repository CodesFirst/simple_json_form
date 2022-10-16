import 'package:flutter/material.dart';

class InputLabel extends StatelessWidget {
  const InputLabel({
    Key? key,
    required this.title,
    required this.labelColor,
    required this.isRTL,
  }) : super(key: key);

  final String? title;
  final Color? labelColor;
  final bool isRTL;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: title != null,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        alignment:
            isRTL == false ? Alignment.centerLeft : Alignment.centerRight,
        child: Text(
          title ?? '',
          style: TextStyle(
            color: labelColor,
          ),
        ),
      ),
    );
  }
}
