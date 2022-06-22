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
  final List<Data> data;

  JsonSchema({required this.data});

  factory JsonSchema.fromJson(Map<String, dynamic> json) => JsonSchema(
      data: json['data'] == null
          ? []
          : List<Data>.from(json['data'].map(
              (e) => Data.fromJson(e),
            )));

  Map<String, dynamic> toJson() => {'data': data.map((v) => v.toJson()).toList()};
}

class Data {
  final List<Questions>? questions;
  //List<Questions>? properties;

  Data({
    this.questions,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        questions: json['questions'] != null
            ? List<Questions>.from(json['questions'].map((e) => Questions.fromJson(e)))
            : null,
      );

  Map<String, dynamic> toJson() => {
        'questions': questions == null ? [] : questions!.map((v) => v.toJson()).toList(),
      };
}

class RepeatEnds {
  String? value;

  RepeatEnds({this.value});

  RepeatEnds.fromJson(Map<String, dynamic> json) {
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['value'] = value;
    return data;
  }
}

class Questions {
  final String? sId;
  final String? title;
  final String? description;
  final List<String>? fields;
  final int? maxline;
  final bool? isMandatory;
  final JsonSchemaType type;
  final String? remarkLabel;
  final String? remarkTitle;
  final bool remark;
  final ValidationSchema? validations;
  dynamic answer;
  String? remarkData;

  Questions({
    this.fields,
    this.sId,
    this.title,
    this.description,
    this.validations,
    required this.type,
    this.maxline,
    this.isMandatory,
    this.remarkLabel,
    this.remarkTitle,
    this.remarkData,
    this.answer,
    this.remark = false,
  });

  factory Questions.fromJson(Map<String, dynamic> json) => Questions(
        fields: json['fields'].cast<String>(),
        sId: json['_id'],
        title: json['title'],
        description: json['description'],
        remark: json['remark'],
        type: stringToJsonSchemaType[json['type']] ?? JsonSchemaType.none,
        maxline: json["maxline"] ?? 1,
        isMandatory: json['is_mandatory'],
        remarkLabel: json['remark_label'],
        remarkTitle: json['remark_title'],
        answer: json['type'] == "checkbox"
            ? List.generate(json['fields'].cast<String>().length, (index) => false)
            : null,
        // validations:
        //     json.containsKey('validations') ? ValidationSchema.fromJSON(json['validations']) : null,
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['fields'] = type == JsonSchemaType.text ? "300" : fields.toString();
    data['_id'] = sId;
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

  Questions copyWith({
    String? sId,
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
      Questions(
        answer: answer ?? this.answer,
        description: description ?? this.description,
        fields: fields ?? this.fields,
        isMandatory: isMandatory ?? this.isMandatory,
        maxline: maxline ?? this.maxline,
        remark: remark ?? this.remark,
        remarkData: remarkData ?? this.remarkData,
        remarkLabel: remarkLabel ?? this.remarkLabel,
        remarkTitle: remarkTitle ?? this.remarkTitle,
        sId: sId ?? this.sId,
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
