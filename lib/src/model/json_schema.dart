import 'package:simple_json_form/src/controller/simple_json_form_controller.dart';
import 'package:simple_json_form/src/key/simple_json_form_key.dart';
import 'package:simple_json_form/src/model/validation_schema.dart';

/// An instance has one of six primitive types, and a range of possible values depending on the type:
enum JsonSchemaType {
  /// multiple:
  /// A "true" or "false" value, from the JSON "true" or "false" value
  multiple,

  /// checkbox:
  /// An ordered list of instances, from the JSON "array" value
  checkbox,

  /// dropdown:
  /// An unordered set of properties mapping a string to an instance, from the JSON "object" value
  dropdown,

  /// number:
  /// An arbitrary-precision, base-10 decimal number value, from the JSON "number" value
  number,

  /// dateTime:
  /// A string of datetime
  datetime,

  /// time:
  /// A string of time
  time,

  /// date:
  /// A string of date
  date,

  /// file:
  /// A string of file
  file,

  /// string:
  /// A string of Unicode code points, from the JSON "string" value
  text,

  /// Format 1
  /// Only Array of String dynamic value  use field raw.
  format1,

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

  Map<String, dynamic> toJson() => {'form': form.map((v) => v.toJson()).toList()};
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
            ? List<Properties>.from(json['properties'].map((e) => Properties.fromJson(e)))
            : null,
      );

  Map<String, dynamic> toJson() => {
        'properties': properties == null ? [] : properties!.map((v) => v.toJson()).toList(),
      };
}

class RawBuilder {
  RawBuilder({
    required this.title,
    required this.properties,
    this.description,
  });

  factory RawBuilder.fromJson(Map<String, dynamic> json) => RawBuilder(
        properties: List<Properties>.from(json['properties'].map((e) => Properties.fromJson(e))),
        title: json['title'],
        description: json['description'],
      );

  Map<String, dynamic> toJson() => {
        'properties': properties.map((v) => v.toJson()).toList(),
      };

  final List<Properties> properties;
  final String title;
  final String? description;
}

class Properties {
  Properties({
    required this.key,
    required this.type,
    required this.title,
    required this.readOnly,
    required this.isRequired,
    this.raw,
    this.description,
    this.fields,
    this.validations,
    this.maxLine,
    this.answer,
  });

  factory Properties.fromJson(Map<String, dynamic> json) => Properties(
        fields: json.containsKey('fields') ? json['fields'].cast<String>() : null,
        key: json['key'],
        title: json['title'],
        description: json['description'],
        type: stringToJsonSchemaType[json['type']] ?? JsonSchemaType.none,
        maxLine: json["maxline"],
        isRequired: json['is_mandatory'] ?? false,
        readOnly: json['readOnly'] ?? false,
        answer: json['type'] == "checkbox"
            ? List.generate(json['fields'].cast<String>().length, (index) => false)
            : null,
        validations: json['validations'] is Map<String, dynamic>
            ? ValidationSchema.fromJSON(json['validations'])
            : null,
        raw: json.containsKey('raw')
            ? List<RawBuilder>.from(json['raw'].map((el) => RawBuilder.fromJson(el)))
            : null,
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['fields'] = type == JsonSchemaType.text ? "300" : fields.toString();
    data['key'] = key;
    data['title'] = title;
    data['description'] = description;
    data['type'] = type.toString();
    data['is_mandatory'] = isRequired;
    data["maxline"] = maxLine;
    data["answer"] = answer.toString();
    return data;
  }

  Properties copyWith({
    String? key,
    String? title,
    String? description,
    int? maxLine,
    bool? readOnly,
    bool? isRequired,
    JsonSchemaType? type,
    List<String>? fields,
    dynamic answer,
  }) =>
      Properties(
        answer: answer ?? this.answer,
        description: description ?? this.description,
        fields: fields ?? this.fields,
        isRequired: isRequired ?? this.isRequired,
        maxLine: maxLine ?? this.maxLine,
        readOnly: readOnly ?? this.readOnly,
        key: key ?? this.key,
        title: title ?? this.title,
        type: type ?? this.type,
      );

  /// A key for use controller and MUST be unique
  final String key;

  /// A descriptive title of the element.
  final String title;

  /// A long description of the element. Used in hover menus and suggestions.
  final String? description;

  /// The value of this keyword MUST be either a string or an array. If it is an array, elements of the array MUST be strings and MUST be unique.
  ///
  /// String values MUST be one of the six primitive types ("null", "boolean", "object", "array", "number", or "string"), or "integer" which matches any number with a zero fractional part.
  ///
  /// An instance validates if and only if the instance is in any of the sets listed for this keyword.
  final JsonSchemaType type;

  /// required
  ///
  /// The value MUST be strings. \
  final bool isRequired;

  /// The value of these keywords MUST be a boolean. When multiple occurrences \
  ///  of these keywords are applicable to a single sub-instance, the resulting \
  ///  behavior SHOULD be as for a true value if any occurrence specifies a true \
  ///  value, and SHOULD be as for a false value otherwise.
  ///
  /// If "readOnly" has a value of boolean true, it indicates that the value of \
  ///  the instance is managed exclusively by the owning authority, and attempts \
  ///  by an application to modify the value of this property are expected to be \
  ///  ignored or rejected by that owning authority.
  final bool readOnly;

  /// The value MUST be int or null
  /// Maxline use for input object
  final int? maxLine;

  /// The value MUST be list of string or null
  /// fields use for form type checkbox, option, and header formater
  ///
  final List<String>? fields;

  //PUT OFF ==>
  // final String? remarkLabel;
  // final String? remarkTitle;
  // final bool remark;
  // String? remarkData;
  //<==

  /// Validation
  /// Object use for model validation
  final ValidationSchema? validations;

  /// raw
  /// Object use for model
  final List<RawBuilder>? raw;

  dynamic answer;
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
  'format1': JsonSchemaType.format1,
  'none': JsonSchemaType.none,
};
