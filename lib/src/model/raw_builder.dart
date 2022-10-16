import 'package:simple_json_form/src/model/json_schema.dart';

class RawBuilder {
  RawBuilder({
    required this.title,
    required this.properties,
    this.description,
  });

  factory RawBuilder.fromJson(Map<String, dynamic> json) => RawBuilder(
        properties: List<Properties>.from(
            json['properties'].map((e) => Properties.fromJson(e))),
        title: json['title'],
        description: json['description'],
      );

  Map<String, dynamic> toJson() => {
        'properties': properties.map((v) => v.toJson()).toList(),
      };

  ///List of properties
  final List<Properties> properties;

  /// Title format string
  final String title;

  /// Description
  final String? description;
}
