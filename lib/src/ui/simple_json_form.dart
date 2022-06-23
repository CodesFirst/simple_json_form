import 'package:flutter/material.dart';
import 'package:simple_json_form/src/key/simple_json_form_key.dart';
import 'package:simple_json_form/src/model/json_schema.dart';
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

  //isJustForm to use for show totally form or one for one
  //final bool isJustForm;

  //imageUrl to use for send services
  final String imageUrl;

  //To use for text the submit button
  final String? submitButtonText;

  //To use for text the previous button
  final String? previousButtonText;

  //To use for text the next button
  final String? nextButtonText;

  //index to use for initial form
  final int index;

  //function to use for get detailt of form
  final Function onSubmit;

  //widget to use loading form
  final Widget? loading;

  //text for use dialog info
  final String? validationTitle;

  //text for use dialog info
  final String? validationDescription;

  const SimpleJsonForm({
    Key? key,
    required this.jsonSchema,
    required this.index,
    required this.imageUrl,
    required this.onSubmit,
    this.crossAxisAlignment = CrossAxisAlignment.start,
    this.padding,
    this.submitButtonText,
    this.nextButtonText,
    this.previousButtonText,
    this.title,
    this.description,
    this.descriptionStyle,
    this.titleStyle,
    this.loading,
    this.validationDescription,
    this.validationTitle,
  }) : super(key: key);

  @override
  State<SimpleJsonForm> createState() => _SimpleJsonFormState();
}

class _SimpleJsonFormState extends State<SimpleJsonForm> {
  int _indexForm = 0;
  @override
  void initState() {
    _indexForm = _indexForm;
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
                    key: SimpleJsonFormKey.keyMapping[widget.jsonSchema.form[i].key],
                    child: Column(
                      children: widget.jsonSchema.form[i].properties!
                          .map(
                            (entry) => SimpleJsonFormField(
                              properties: entry,
                              imageUrl: widget.imageUrl,
                              descriptionTextDecoration: const TextStyle(color: Colors.grey),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                );
              },
            ),

            // Form(
            //   key: SimpleJsonFormKey.keyMapping[widget.jsonSchema.data[_indexForm].key],
            //   child: Column(
            //     children: widget.jsonSchema.data[_indexForm].questions!
            //         .map(
            //           (entry) => SimpleJsonFormField(
            //             question: entry,
            //             imageUrl: widget.imageUrl,
            //             descriptionTextDecoration: const TextStyle(color: Colors.grey),
            //           ),
            //         )
            //         .toList(),
            //   ),
            // ),

            // ...widget.jsonSchema.data[_indexForm].questions!.map(
            //   (entry) => SimpleJsonFormField(
            //     question: entry,
            //     imageUrl: widget.imageUrl,
            //     descriptionTextDecoration: const TextStyle(color: Colors.grey),
            //   ),
            // ),
            const SizedBox(height: 10),
            widget.jsonSchema.form.isNotEmpty
                ? FormButton(
                    lengthForm: widget.jsonSchema.form.length,
                    indexForm: _indexForm,
                    nextText: widget.nextButtonText ?? 'Next',
                    previousText: widget.previousButtonText ?? 'Previous',
                    submitText: widget.submitButtonText ?? 'Submit',
                    onNext: () {
                      final next = _nextForm(_indexForm);
                      if (next) {
                        setState(() {
                          _indexForm = _indexForm + 1;
                        });
                      }
                    },
                    onPrevious: () {
                      //final next = getPreviousData(_indexForm);
                      //if (next) {
                      setState(() {
                        _indexForm = _indexForm - 1;
                      });
                      //}
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
    final formKey = SimpleJsonFormKey.keyMapping[widget.jsonSchema.form[_indexForm].key];
    if (formKey?.currentState?.validate() ?? false) return widget.jsonSchema;
    return null;
  }

  bool _nextForm(int index) {
    if (widget.jsonSchema.form.isEmpty) return false;
    final formKey = SimpleJsonFormKey.keyMapping[widget.jsonSchema.form[_indexForm].key];
    if (formKey?.currentState?.validate() ?? false) return true;
    DialogForm.of(context: context).infoDialog(
      title: widget.validationTitle,
      description: widget.validationDescription,
    );
    return false;
  }

  bool getPreviousData(int index) {
    if (widget.jsonSchema.form.isEmpty) return false;
    final formKey = SimpleJsonFormKey.keyMapping[widget.jsonSchema.form[_indexForm].key];
    if (formKey?.currentState?.validate() ?? false) return true;
    return false;
  }
}

class _FormBuilderWidget extends StatelessWidget {
  const _FormBuilderWidget({
    Key? key,
    required this.jsonSchema,
    required this.imageUrl,
  }) : super(key: key);

  final JsonSchema jsonSchema;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: jsonSchema.form.length,
        itemBuilder: (context, index) {
          return Form(
            key: SimpleJsonFormKey.keyMapping[jsonSchema.form[index].key],
            child: Column(
              children: jsonSchema.form[index].properties!
                  .map(
                    (entry) => SimpleJsonFormField(
                      properties: entry,
                      imageUrl: imageUrl,
                      descriptionTextDecoration: const TextStyle(color: Colors.grey),
                    ),
                  )
                  .toList(),
            ),
          );
        },
      ),
    );
  }
}
