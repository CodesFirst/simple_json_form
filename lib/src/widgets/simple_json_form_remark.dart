import 'package:flutter/material.dart';
import 'package:simple_json_form/simple_json_form.dart';
import 'package:simple_json_form/src/controller/simple_json_form_controller.dart';
import 'package:simple_json_form/src/widgets/input_text.dart';

class SimpleJsonFormRemark extends StatelessWidget {
  const SimpleJsonFormRemark({
    Key? key,
    required this.properties,
  }) : super(key: key);
  final Properties properties;

  @override
  Widget build(BuildContext context) {
    final controller =
        SimpleJsonFormController.getKeyController('${properties.key}_remark');
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8),
      child: Column(
        children: [
          InputText(
            controller: controller,
            title: properties.remarkTitle ?? 'Enter remarks',
            labelText: properties.remarkLabel ?? 'Enter the remark',
            onChanged: (value) {
              properties.remarkData = value;
            },
          ),
        ],
      ),
    );
  }
}
