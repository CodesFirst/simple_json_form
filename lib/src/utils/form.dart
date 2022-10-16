import 'package:flutter/services.dart';

String? validateEmptyField(String? value, String error) {
  if (value == null) return null;
  return value.isEmpty ? error : null;
}

String? validateEmailField(String? value, String error) {
  if (value == null) return null;
  if (value.isEmpty) return error;
  final regExp = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  if (!regExp.hasMatch(value)) return 'El formato ingresado es inválido.';
  return value.isEmpty ? error : null;
}

String? validateEmptyFieldWithLength(
    String? value, int min, int max, String error) {
  if (value == null) return null;
  return value.isEmpty
      ? error
      : (value.length >= min && value.length <= max)
          ? null
          : "La longitud requerida del campo debe tener mínimo $min caracteres y máximo $max caracteres";
}

class NumericalRangeFormatter extends TextInputFormatter {
  final int min;
  final int max;

  NumericalRangeFormatter({required this.min, required this.max});

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text == '') {
      return newValue;
    } else if (int.parse(newValue.text) < min) {
      return const TextEditingValue().copyWith(text: min.toString());
    } else {
      return int.parse(newValue.text) > max ? oldValue : newValue;
    }
  }
}

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}

class LowerCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text.toLowerCase(),
      selection: newValue.selection,
    );
  }
}
