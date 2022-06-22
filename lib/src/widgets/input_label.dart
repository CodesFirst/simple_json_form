import 'package:flutter/material.dart';

class InputLabel extends StatelessWidget {
  const InputLabel({
    Key? key,
    required this.title,
    required this.labelColor,
  }) : super(key: key);

  final String? title;
  final Color? labelColor;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: title != null,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        alignment: Alignment.centerLeft,
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
