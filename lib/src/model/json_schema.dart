import 'package:simple_json_form/src/controller/simple_json_form_controller.dart';
import 'package:simple_json_form/src/key/simple_json_form_key.dart';
import 'package:simple_json_form/src/model/validation_schema.dart';

/// An instance has one of six primitive types, and a range of possible values depending on the type:
enum JsonSchemaType {
  /// multiple:
  /// A "true" or "false" value, from the JSON "true" or "false" value
  multiple,

  /// object:
  /// An unordered set of properties mapping a string to an instance, from the JSON "object" value
  dropdown,

  /// array:
  /// An ordered list of instances, from the JSON "array" value
  checkbox,

  /// number:
  /// An arbitrary-precision, base-10 decimal number value, from the JSON "number" value
  number,

  /// string:
  /// A string of Unicode code points, from the JSON "string" value
  datetime,

  time,

  date,

  file,

  text,

  string,

  /// SPECIAL_CASE_NONE:
  /// A special case for when the type is not defined.
  none,
}

class JsonSchema {
  final List<FormBuilder> form;

  JsonSchema({required this.form});

  factory JsonSchema.fromJson(Map<String, dynamic> json) {
    final jsonSchema = JsonSchema(
      form: json['form'] == null
          ? []
          : List<FormBuilder>.from(
              json['form'].map(
                (e) => FormBuilder.fromJson(e),
              ),
            ),
    );
    SimpleJsonFormKey(jsonSchema: jsonSchema);
    SimpleJsonFormController(jsonSchema: jsonSchema);
    return jsonSchema;
  }

  Map<String, dynamic> toJson() =>
      {'form': form.map((v) => v.toJson()).toList()};
}

class FormBuilder {
  final List<Properties>? properties;
  final String key;
  //List<Questions>? properties;

  FormBuilder({
    required this.key,
    this.properties,
  });

  factory FormBuilder.fromJson(Map<String, dynamic> json) => FormBuilder(
        key: json['key'],
        properties: json['properties'] != null
            ? List<Properties>.from(
                json['properties'].map((e) => Properties.fromJson(e)))
            : null,
      );

  Map<String, dynamic> toJson() => {
        'properties': properties == null
            ? []
            : properties!.map((v) => v.toJson()).toList(),
      };
}

class Properties {
  final String key;
  final String? title;
  final String? description;
  final List<String>? fields;
  final int? maxline;
  final bool isMandatory;
  final JsonSchemaType type;
  final String? remarkLabel;
  final String? remarkTitle;
  final bool remark;
  final ValidationSchema? validations;
  dynamic answer;
  String? remarkData;

  Properties({
    required this.key,
    required this.type,
    this.fields,
    this.title,
    this.description,
    this.validations,
    this.maxline,
    this.remarkLabel,
    this.remarkTitle,
    this.remarkData,
    this.answer,
    this.isMandatory = false,
    this.remark = false,
  });

  factory Properties.fromJson(Map<String, dynamic> json) => Properties(
        fields:
            json.containsKey('fields') ? json['fields'].cast<String>() : null,
        key: json['key'],
        title: json['title'],
        description: json['description'],
        remark: json['remark'],
        type: stringToJsonSchemaType[json['type']] ?? JsonSchemaType.none,
        maxline: json["maxline"] ?? 1,
        isMandatory: json['is_mandatory'] ?? false,
        remarkLabel: json['remark_label'],
        remarkTitle: json['remark_title'],
        answer: json['type'] == "checkbox"
            ? List.generate(
                json['fields'].cast<String>().length, (index) => false)
            : null,
        validations: json['validations'] is Map<String, dynamic>
            ? ValidationSchema.fromJSON(json['validations'])
            : null,
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['fields'] = type == JsonSchemaType.text ? "300" : fields.toString();
    data['key'] = key;
    data['title'] = title;
    data['description'] = description;
    data['remark'] = remark;
    data["remark_data"] = remarkData;
    data['type'] = type.toString();
    data['is_mandatory'] = isMandatory;
    data["maxline"] = maxline;
    data["remark_label"] = remarkLabel;
    data["answer"] = answer.toString();
    data["remark_title"] = remarkTitle;
    return data;
  }

  Properties copyWith({
    String? key,
    String? title,
    String? description,
    List<String>? fields,
    int? maxline,
    bool? isMandatory,
    JsonSchemaType? type,
    String? remarkLabel,
    String? remarkTitle,
    String? remarkData,
    dynamic answer,
    bool? remark,
  }) =>
      Properties(
        answer: answer ?? this.answer,
        description: description ?? this.description,
        fields: fields ?? this.fields,
        isMandatory: isMandatory ?? this.isMandatory,
        maxline: maxline ?? this.maxline,
        remark: remark ?? this.remark,
        remarkData: remarkData ?? this.remarkData,
        remarkLabel: remarkLabel ?? this.remarkLabel,
        remarkTitle: remarkTitle ?? this.remarkTitle,
        key: key ?? this.key,
        title: title ?? this.title,
        type: type ?? this.type,
      );
}

Map<String, JsonSchemaType> stringToJsonSchemaType = {
  'multiple': JsonSchemaType.multiple,
  'dropdown': JsonSchemaType.dropdown,
  'checkbox': JsonSchemaType.checkbox,
  'number': JsonSchemaType.number,
  'datetime': JsonSchemaType.datetime,
  'time': JsonSchemaType.time,
  'date': JsonSchemaType.date,
  'file': JsonSchemaType.file,
  'text': JsonSchemaType.text,
  'string': JsonSchemaType.string,
  'none': JsonSchemaType.none,
};
