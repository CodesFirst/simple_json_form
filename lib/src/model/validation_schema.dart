class ValidationSchema {
  final FormatType format;
  final Length length;
  final String message;

  ValidationSchema({
    required this.message,
    required this.format,
    required this.length,
  });

  factory ValidationSchema.fromJSON(Map<String, dynamic> json) => ValidationSchema(
        length: Length.fromJSON(json['length'] ?? {}),
        format: stringToFormatType[json['type']] ?? FormatType.none,
        message: json['message'] ?? 'Field is required',
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
