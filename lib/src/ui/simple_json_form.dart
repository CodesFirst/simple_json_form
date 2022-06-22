import 'package:flutter/material.dart';
import 'package:simple_json_form/src/model/json_schema.dart';
import 'package:simple_json_form/src/widgets/form_button.dart';
import 'package:simple_json_form/src/widgets/simple_json_form_field.dart';

// class SimpleJsonForm extends StatelessWidget {
//   const SimpleJsonForm({
//     Key? key,
//     required this.jsonSchema,
//     required this.index,
//     required this.imageUrl,
//     required this.onSubmit,
//     this.crossAxisAlignment = CrossAxisAlignment.start,
//     this.padding,
//     this.submitButtonText,
//     this.nextButtonText,
//     this.previousButtonText,
//     this.title,
//     this.description,
//     this.descriptionStyle,
//     this.titleStyle,
//   }) : super(key: key);

//   //JSON Schema to use to generate the form.
//   final JsonSchema jsonSchema;

//   //crossAxisAlignment to use general form
//   final CrossAxisAlignment crossAxisAlignment;

//   //padding to use general form
//   final EdgeInsetsGeometry? padding;

//   //Title general to use the form
//   final String? title;

//   //title style to use title the form
//   final TextStyle? titleStyle;

//   //Description general to use the form
//   final String? description;

//   //Description style to use description form
//   final TextStyle? descriptionStyle;

//   //isJustForm to use for show totally form or one for one
//   //final bool isJustForm;

//   //imageUrl to use for send services
//   final String imageUrl;

//   //To use for text the submit button
//   final String? submitButtonText;

//   //To use for text the previous button
//   final String? previousButtonText;

//   //To use for text the next button
//   final String? nextButtonText;

//   //index to use for initial form
//   final int index;

//   //function to use for get detailt of form
//   final Function onSubmit;

//   @override
//   Widget build(BuildContext context) {
//     final indexForm = context.watch<SimpleJsonFromViewModel>().indexForm;
//     return ChangeNotifierProvider(
//       create: (context) => SimpleJsonFromViewModel()..init(index),
//       child: SingleChildScrollView(
//         child: Container(
//           padding: padding,
//           child: Column(
//             crossAxisAlignment: crossAxisAlignment,
//             children: [
//               if (title != null)
//                 Text(
//                   title!,
//                   style: titleStyle,
//                   textAlign: TextAlign.center,
//                 ),
//               if (description != null)
//                 Text(
//                   description!,
//                   style: descriptionStyle,
//                 ),

//               //show form if exist

//               ...jsonSchema.data[indexForm].questions!.map(
//                 (entry) => SimpleJsonFormField(
//                   question: entry,
//                   imageUrl: imageUrl,
//                   descriptionTextDecoration: const TextStyle(color: Colors.grey),
//                 ),
//               ),
//               const SizedBox(height: 10),

//               jsonSchema.data.length == (indexForm + 1)
//                   ? Center(
//                       child: PrimaryButton(
//                           onPressed: () {
//                             onSubmit(getCompleteData(context, indexForm));
//                           },
//                           text: submitButtonText ?? "Submit"),
//                     )
//                   : Center(
//                       child: PrimaryButton(
//                           onPressed: () {
//                             final next = getNextData(context, indexForm);
//                             if (next) {
//                               context
//                                   .read<SimpleJsonFromViewModel>()
//                                   .changeIndexForm(indexForm + 1);
//                             }
//                           },
//                           text: nextButtonText ?? "Next"),
//                     )
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   getCompleteData(BuildContext context, int index) {
//     if (jsonSchema.data.isEmpty) return jsonSchema;
//     int f = 0;
//     List<Questions>? questions = jsonSchema.data[index].questions;
//     for (Questions item in questions!) {
//       if (item.answer == null && item.isMandatory == true) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text("${item.title} is mandatory"),
//           ),
//         );
//         f = 1;
//         break;
//       }
//     }
//     return f == 0 ? jsonSchema : null;
//   }

//   bool getNextData(BuildContext context, int index) {
//     if (jsonSchema.data.isEmpty) return false;
//     int f = 0;
//     List<Questions>? questions = jsonSchema.data[index].questions;
//     for (Questions item in questions!) {
//       if (item.answer == null && item.isMandatory == true) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text("${item.title} es mandatorio"),
//           ),
//         );
//         f = 1;
//         break;
//       }
//     }
//     return f == 0 ? true : false;
//   }
// }

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

            ...widget.jsonSchema.data[_indexForm].questions!.map(
              (entry) => SimpleJsonFormField(
                question: entry,
                imageUrl: widget.imageUrl,
                descriptionTextDecoration: const TextStyle(color: Colors.grey),
              ),
            ),
            const SizedBox(height: 10),

            FormButton(
              lengthForm: widget.jsonSchema.data.length,
              indexForm: _indexForm,
              nextText: widget.nextButtonText ?? 'Next',
              previousText: widget.previousButtonText ?? 'Previous',
              submitText: widget.submitButtonText ?? 'Submit',
              onNext: () {
                final next = getNextData(_indexForm);
                if (next) {
                  setState(() {
                    _indexForm = _indexForm + 1;
                  });
                }
              },
              onPrevious: () {
                final next = getPreviousData(_indexForm);
                if (next) {
                  setState(() {
                    _indexForm = _indexForm - 1;
                  });
                }
              },
              onSubmit: () => widget.onSubmit(getCompleteData(_indexForm)),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  getCompleteData(int index) {
    if (widget.jsonSchema.data.isEmpty) return widget.jsonSchema;
    int f = 0;
    List<Questions>? questions = widget.jsonSchema.data[index].questions;
    for (Questions item in questions!) {
      if (item.answer == null && item.isMandatory == true) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("${item.title} is mandatory"),
          ),
        );
        f = 1;
        break;
      }
    }
    return f == 0 ? widget.jsonSchema : null;
  }

  bool getNextData(int index) {
    if (widget.jsonSchema.data.isEmpty) return false;
    int f = 0;
    List<Questions>? questions = widget.jsonSchema.data[index].questions;
    for (Questions item in questions!) {
      if (item.answer == null && item.isMandatory == true) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("${item.title} es mandatorio"),
          ),
        );
        f = 1;
        break;
      }
    }
    return f == 0 ? true : false;
  }

  bool getPreviousData(int index) {
    if (widget.jsonSchema.data.isEmpty) return false;
    int f = 0;
    List<Questions>? questions = widget.jsonSchema.data[index].questions;
    for (Questions item in questions!) {
      if (item.answer == null && item.isMandatory == true) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("${item.title} es mandatorio"),
          ),
        );
        f = 1;
        break;
      }
    }
    return f == 0 ? true : false;
  }
}
