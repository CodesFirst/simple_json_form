import 'package:flutter/widgets.dart';
import 'package:simple_json_form/simple_json_form.dart';

class SimpleJsonFormKey {
  SimpleJsonFormKey({required this.jsonSchema}) {
    keyMapping = generateKeyMapping(jsonSchema);
  }

  final JsonSchema jsonSchema;
  static Map<String, GlobalKey<FormState>> keyMapping = {};

  Map<String, GlobalKey<FormState>> generateKeyMapping(JsonSchema jsonSchema) {
    Map<String, GlobalKey<FormState>> keyMapping = {};
    for (var entry in jsonSchema.form) {
      keyMapping[entry.key] = GlobalKey<FormState>();
    }
    return keyMapping;
  }
}
