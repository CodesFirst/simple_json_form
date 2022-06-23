import 'package:flutter/widgets.dart';
import 'package:simple_json_form/simple_json_form.dart';

class SimpleJsonFormController {
  SimpleJsonFormController({required this.jsonSchema}) {
    controllerMapping = generateKeyMapping(jsonSchema);
  }

  final JsonSchema jsonSchema;

  static Map<String, TextEditingController> controllerMapping = {};

  Map<String, TextEditingController> generateKeyMapping(JsonSchema jsonSchema) {
    Map<String, TextEditingController> keyMapping = {};
    for (var entry in jsonSchema.form) {
      for (Properties property in entry.properties ?? []) {
        if (property.remark) {
          keyMapping['${property.key}_remark'] = TextEditingController();
        }

        if (property.type == JsonSchemaType.text ||
            property.type == JsonSchemaType.number ||
            property.type == JsonSchemaType.string ||
            property.type == JsonSchemaType.date ||
            property.type == JsonSchemaType.time) {
          keyMapping[property.key] = TextEditingController();
        }
      }
    }
    return keyMapping;
  }

  static TextEditingController? getKeyController(String key) {
    return controllerMapping.containsKey(key) ? controllerMapping[key] : null;
  }
}
