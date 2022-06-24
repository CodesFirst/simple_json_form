import 'package:flutter/widgets.dart';

@immutable
class DefaultValues {
  const DefaultValues.raw({
    required this.hintDropdownText,
    required this.nextButtonText,
    required this.previousButtonText,
    required this.submitButtonText,
    required this.validationDescription,
    required this.validationTitle,
    required this.fieldRequired,
  });

  factory DefaultValues({
    String? submitButtonText,
    String? previousButtonText,
    String? nextButtonText,
    String? validationTitle,
    String? validationDescription,
    String? hintDropdownText,
    String? fieldRequired,
  }) {
    submitButtonText = submitButtonText ??= 'Submit';
    previousButtonText = previousButtonText ??= 'Previous';
    nextButtonText = nextButtonText ??= 'nextButtonText';
    validationTitle = validationTitle ??= 'Failed validations';
    validationDescription =
        validationDescription ??= 'Some fields require your validation';
    hintDropdownText = hintDropdownText ??= 'Select option';
    fieldRequired = fieldRequired ??= 'Field is required';
    return DefaultValues.raw(
      hintDropdownText: hintDropdownText,
      nextButtonText: nextButtonText,
      previousButtonText: previousButtonText,
      submitButtonText: submitButtonText,
      validationDescription: validationDescription,
      validationTitle: validationTitle,
      fieldRequired: fieldRequired,
    );
  }

  DefaultValues copyWith({
    String? submitButtonText,
    String? previousButtonText,
    String? nextButtonText,
    String? validationTitle,
    String? validationDescription,
    String? hintDropdownText,
    String? fieldRequired,
  }) =>
      DefaultValues(
        hintDropdownText: hintDropdownText ?? this.hintDropdownText,
        nextButtonText: nextButtonText ?? this.nextButtonText,
        previousButtonText: previousButtonText ?? this.previousButtonText,
        submitButtonText: submitButtonText ?? this.submitButtonText,
        validationDescription:
            validationDescription ?? this.validationDescription,
        validationTitle: validationTitle ?? this.validationTitle,
        fieldRequired: fieldRequired ?? this.fieldRequired,
      );

  //To use for text the submit button
  final String submitButtonText;

  //To use for text the previous button
  final String previousButtonText;

  //To use for text the next button
  final String nextButtonText;

  //text for use dialog info
  final String validationTitle;

  //text for use dialog info
  final String validationDescription;

  //hintDropdownText to use display hint dropdown in form
  final String hintDropdownText;

  final String fieldRequired;
}
