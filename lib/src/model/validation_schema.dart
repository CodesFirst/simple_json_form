class ValidationSchema {
  final FormatType format;
  final Length length;
  final int maxline;
  final String message;

  ValidationSchema({
    required this.message,
    required this.format,
    required this.length,
    this.maxline = 0,
  });

  factory ValidationSchema.fromJSON(Map<String, dynamic> json) => ValidationSchema(
        length: Length.fromJSON(json['length'] ?? {}),
        maxline: json['maxline'] ?? 0,
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
