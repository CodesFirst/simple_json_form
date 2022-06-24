import 'package:flutter/material.dart';
import 'package:simple_json_form/simple_json_form.dart';
import 'package:simple_json_form/src/key/simple_json_form_key.dart';
import 'package:simple_json_form/src/utils/dialog_form.dart';
import 'package:simple_json_form/src/widgets/form_button.dart';
import 'package:simple_json_form/src/widgets/simple_json_form_field.dart';

class SimpleJsonForm extends StatefulWidget {
  //JSON Schema to use to generate the form.
  final JsonSchema jsonSchema;

  //crossAxisAlignment to use general form
  final CrossAxisAlignment crossAxisAlignment;

  //padding to use general form
  final EdgeInsetsGeometry? padding;

  //Title general to use the form
  final String? title;

  //title style to use title the form
  final TextStyle? titleStyle;

  //Description general to use the form
  final String? description;

  //Description style to use description form
  final TextStyle? descriptionStyle;

  //Value for default to use in form
  final DefaultValues? defaultValues;

  //isJustForm to use for show totally form or one for one
  //final bool isJustForm;

  //imageUrl to use for send services
  final String imageUrl;

  //index to use for initial form
  final int index;

  //function to use for get detailt of form
  final Function onSubmit;

  //widget to use loading form
  final Widget? loading;

  //description to use for style text title widget form
  final TextStyle? descriptionStyleText;

  //description to use style text description widget form
  final TextStyle? titleStyleText;

  const SimpleJsonForm({
    Key? key,
    required this.jsonSchema,
    required this.index,
    required this.imageUrl,
    required this.onSubmit,
    this.defaultValues,
    this.crossAxisAlignment = CrossAxisAlignment.start,
    this.padding,
    this.title,
    this.description,
    this.descriptionStyle,
    this.titleStyle,
    this.loading,
    this.descriptionStyleText,
    this.titleStyleText,
  }) : super(key: key);

  @override
  State<SimpleJsonForm> createState() => _SimpleJsonFormState();
}

class _SimpleJsonFormState extends State<SimpleJsonForm> {
  int _indexForm = 0;
  late DefaultValues defaultValues;
  @override
  void initState() {
    _indexForm = _indexForm;
    defaultValues = widget.defaultValues ?? DefaultValues();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: widget.padding,
        child: Column(
          crossAxisAlignment: widget.crossAxisAlignment,
          children: [
            if (widget.title != null)
              Text(
                widget.title!,
                style: widget.titleStyle,
                textAlign: TextAlign.center,
              ),
            if (widget.description != null)
              Text(
                widget.description!,
                style: widget.descriptionStyle,
              ),

            //show form if exist
            ...List.generate(
              widget.jsonSchema.form.length,
              (i) {
                return Visibility(
                  visible: i == _indexForm,
                  child: Form(
                    key: SimpleJsonFormKey
                        .keyMapping[widget.jsonSchema.form[i].key],
                    child: Column(
                      children: widget.jsonSchema.form[i].properties!
                          .map(
                            (entry) => SimpleJsonFormField(
                              properties: entry,
                              imageUrl: widget.imageUrl,
                              descriptionStyleText: widget.descriptionStyleText,
                              titleStyleText: widget.titleStyleText,
                              hintDropdownText: defaultValues.hintDropdownText,
                            ),
                          )
                          .toList(),
                    ),
                  ),
                );
              },
            ),

            const SizedBox(height: 10),
            widget.jsonSchema.form.isNotEmpty
                ? FormButton(
                    lengthForm: widget.jsonSchema.form.length,
                    indexForm: _indexForm,
                    nextText: defaultValues.nextButtonText,
                    previousText: defaultValues.previousButtonText,
                    submitText: defaultValues.submitButtonText,
                    onNext: () {
                      final next = _nextForm(_indexForm);
                      if (next) {
                        setState(() {
                          _indexForm = _indexForm + 1;
                        });
                      }
                    },
                    onPrevious: () {
                      setState(() {
                        _indexForm = _indexForm - 1;
                      });
                    },
                    onSubmit: () => widget.onSubmit(_completeForm(_indexForm)),
                  )
                : SizedBox.fromSize(),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  _completeForm(int index) {
    if (widget.jsonSchema.form.isEmpty) return widget.jsonSchema;
    final formKey =
        SimpleJsonFormKey.keyMapping[widget.jsonSchema.form[_indexForm].key];
    if (formKey?.currentState?.validate() ?? false) return widget.jsonSchema;
    return null;
  }

  bool _nextForm(int index) {
    if (widget.jsonSchema.form.isEmpty) return false;
    final formKey =
        SimpleJsonFormKey.keyMapping[widget.jsonSchema.form[_indexForm].key];
    if (formKey?.currentState?.validate() ?? false) return true;
    DialogForm.of(context: context).infoDialog(
      title: defaultValues.validationTitle,
      description: defaultValues.validationDescription,
    );
    return false;
  }
}
