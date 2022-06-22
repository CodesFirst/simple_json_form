class ValidationSchema {
  final Length? length;
  final FormatType? format;

  ValidationSchema({this.length, this.format});

  factory ValidationSchema.fromJSON(Map<String, dynamic> json) => ValidationSchema(
        length: json.containsKey('length')
            ? Length.fromJSON(
                json['length'],
              )
            : null,
        format: stringToFormatType[json['type']] ?? FormatType.none,
      );
}

class Length {
  final int max;
  final int min;

  Length({
    required this.max,
    required this.min,
  });

  factory Length.fromJSON(Map<String, dynamic> json) => Length(
        max: json['max'] ?? 5,
        min: json['min'] ?? 0,
      );
}

enum FormatType { none, email, text, number }

Map<String, FormatType> stringToFormatType = {
  'none': FormatType.none,
  'email': FormatType.email,
  'text': FormatType.text,
  'number': FormatType.number,
};
