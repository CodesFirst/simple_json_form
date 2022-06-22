import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:simple_json_form/simple_json_form.dart';
import 'package:simple_json_form/src/utils/responsive.dart';
import 'package:simple_json_form/src/utils/utils.dart';
import 'package:simple_json_form/src/widgets/custom_dropdown_widget.dart';
import 'package:simple_json_form/src/widgets/input_text.dart';
import 'package:simple_json_form/src/widgets/text_cfirst.dart';

class SimpleJsonFormField extends StatefulWidget {
  const SimpleJsonFormField({
    Key? key,
    required this.question,
    required this.imageUrl,
    this.descriptionTextDecoration,
  }) : super(key: key);

  final Questions question;
  final String imageUrl;
  final TextStyle? descriptionTextDecoration;
  @override
  State<SimpleJsonFormField> createState() => _SimpleJsonFormFieldState();
}

class _SimpleJsonFormFieldState extends State<SimpleJsonFormField> {
  @override
  Widget build(BuildContext context) {
    switch (widget.question.type) {
      case JsonSchemaType.multiple:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 16.0, top: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: Text(widget.question.title ?? ''),
                  ),
                  if (widget.question.description != null)
                    Text(
                      widget.question.description!,
                      style: widget.descriptionTextDecoration,
                    ),
                ],
              ),
            ),
            ...widget.question.fields!.map(
              (entry) => RadioListTile(
                value: entry,
                groupValue: widget.question.answer,
                title: Text(
                  entry,
                  style: TextStyle(
                    color: widget.question.answer != entry ? Colors.grey : Colors.black,
                    fontWeight: FontWeight.normal,
                    fontSize: Responsive.of(context).dp(1.2),
                  ),
                ),
                onChanged: (value) {
                  widget.question.answer = value;
                  setState(() {});
                },
              ),
            ),
            remarkWidget(),
          ],
        );
      case JsonSchemaType.dropdown:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 16.0, top: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: Text(widget.question.title ?? ''),
                  ),
                  if (widget.question.description != null)
                    Text(
                      widget.question.description!,
                      style: widget.descriptionTextDecoration,
                    ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 16.0,
                horizontal: 24,
              ),
              child: Container(
                width: getpropScreenWidth(0.9, context),
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(
                    color: widget.question.answer != null ? Colors.blue : Colors.grey,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DropdownButton(
                    underline: const SizedBox(),
                    hint: widget.question.answer == null
                        ? const TextCFirst('Select option')
                        : Text(
                            widget.question.answer,
                            style: TextStyle(
                              color: widget.question.answer != null ? Colors.blue : Colors.grey,
                            ),
                          ),
                    isExpanded: true,
                    iconSize: 30.0,
                    style: const TextStyle(color: Colors.grey),
                    items: widget.question.fields!.map(
                      (val) {
                        return DropdownMenuItem<String>(
                          value: val,
                          child: Text(val),
                        );
                      },
                    ).toList(),
                    onChanged: (value) {
                      setState(() {
                        widget.question.answer = value;
                      });
                    },
                  ),
                ),
              ),
            ),
            remarkWidget(),
          ],
        );

      case JsonSchemaType.checkbox:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 16.0, top: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: Text(widget.question.title ?? ''),
                  ),
                  if (widget.question.description != null)
                    Text(
                      widget.question.description!,
                      style: widget.descriptionTextDecoration,
                    ),
                ],
              ),
            ),
            ...widget.question.fields!.map(
              (entry) => CheckboxListTile(
                controlAffinity: ListTileControlAffinity.leading,
                dense: true,
                title: Text(
                  entry,
                  style: TextStyle(
                    color: widget.question.answer[widget.question.fields!.indexOf(entry)] != true
                        ? Colors.grey
                        : Colors.black,
                    fontWeight: FontWeight.normal,
                    fontSize: Responsive.of(context).dp(0.4),
                  ),
                ),
                value: widget.question.answer[widget.question.fields!.indexOf(entry)],
                onChanged: (value) {
                  widget.question.answer[widget.question.fields!.indexOf(entry)] = value;
                  setState(() {});
                },
              ),
            ),
            remarkWidget(),
          ],
        );

      case JsonSchemaType.datetime:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 16.0, top: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: Text(widget.question.title ?? ''),
                  ),
                  if (widget.question.description != null)
                    Text(
                      widget.question.description!,
                      style: widget.descriptionTextDecoration,
                    ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Row(
                children: <Widget>[
                  Theme(
                    data: ThemeData(),
                    child: Builder(
                      builder: (context) => CustomDropdownWidget(
                        onChanged: (val) {
                          if (kDebugMode) {
                            print(val);
                          }
                        },
                        onTap: () async {
                          DateTime tempDate = await selectDate(context);

                          if (widget.question.answer == null) {
                            setState(() {
                              widget.question.answer = tempDate;
                            });
                          } else {
                            setState(() {
                              widget.question.answer = DateTime(
                                tempDate.year,
                                tempDate.month,
                                tempDate.day,
                                widget.question.answer.hour,
                                widget.question.answer.minute,
                              );
                            });
                          }
                        },
                        title: widget.question.answer == null
                            ? "DD-MM-YYYY"
                            : DateFormat('dd-MM-yyyy').format(widget.question.answer),
                        // date != null ? dateFormater.format(date) : "DD-MM-YYYY",

                        isRequired: false,
                        width: getpropScreenWidth(0.4, context),
                      ),
                    ),
                  ),
                  CustomDropdownWidget(
                    onChanged: (val) {},
                    onTap: () async {
                      TimeOfDay tempTime = await selectTime(context);

                      if (widget.question.answer == null) {
                        setState(() {
                          widget.question.answer = DateTime(
                            DateTime.now().year,
                            DateTime.now().month,
                            DateTime.now().day,
                            tempTime.hour,
                            tempTime.minute,
                          );
                        });
                      } else {
                        setState(() {
                          widget.question.answer = DateTime(
                            widget.question.answer.year,
                            widget.question.answer.month,
                            widget.question.answer.day,
                            tempTime.hour,
                            tempTime.minute,
                          );
                        });
                      }

                      // reminderController.updateIschanged(true);
                    },
                    title: widget.question.answer != null
                        ? formatTimeOfDay(TimeOfDay.fromDateTime(widget.question.answer))
                        : "Hr:Mins",
                    isRequired: false,
                    width: getpropScreenWidth(0.3, context),
                  ),
                ],
              ),
            ),
            remarkWidget(),
          ],
        );
      case JsonSchemaType.time:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 16.0, top: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: Text(widget.question.title ?? ''),
                  ),
                  if (widget.question.description != null)
                    Text(
                      widget.question.description!,
                      style: widget.descriptionTextDecoration,
                    ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Row(
                children: <Widget>[
                  CustomDropdownWidget(
                    onChanged: (val) {},
                    onTap: () async {
                      TimeOfDay tempTime = await selectTime(context);

                      if (widget.question.answer == null) {
                        setState(() {
                          widget.question.answer = DateTime(
                            DateTime.now().year,
                            DateTime.now().month,
                            DateTime.now().day,
                            tempTime.hour,
                            tempTime.minute,
                          );
                        });
                      } else {
                        setState(() {
                          widget.question.answer = DateTime(
                            widget.question.answer.year,
                            widget.question.answer.month,
                            widget.question.answer.day,
                            tempTime.hour,
                            tempTime.minute,
                          );
                        });
                      }

                      // reminderController.updateIschanged(true);
                    },
                    title: widget.question.answer != null
                        ? formatTimeOfDay(TimeOfDay.fromDateTime(widget.question.answer))
                        : "Hr:Mins",
                    isRequired: false,
                    width: getpropScreenWidth(0.3, context),
                  ),
                ],
              ),
            ),
            remarkWidget(),
          ],
        );

      case JsonSchemaType.date:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 16.0, top: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: Text(widget.question.title ?? ''),
                  ),
                  if (widget.question.description != null)
                    Text(
                      widget.question.description!,
                      style: widget.descriptionTextDecoration,
                    ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Row(
                children: <Widget>[
                  Theme(
                    data: ThemeData(),
                    child: Builder(
                      builder: (context) => CustomDropdownWidget(
                        onChanged: (val) {
                          if (kDebugMode) {
                            print(val);
                          }
                        },
                        onTap: () async {
                          DateTime tempDate = await selectDate(context);

                          if (widget.question.answer == null) {
                            setState(() {
                              widget.question.answer = tempDate;
                            });
                          } else {
                            setState(() {
                              widget.question.answer = DateTime(
                                tempDate.year,
                                tempDate.month,
                                tempDate.day,
                                widget.question.answer.hour,
                                widget.question.answer.minute,
                              );
                            });
                          }
                        },
                        title: widget.question.answer == null
                            ? "DD-MM-YYYY"
                            : DateFormat('dd-MM-yyyy').format(widget.question.answer),
                        // date != null ? dateFormater.format(date) : "DD-MM-YYYY",

                        isRequired: false,
                        width: Responsive.of(context).wp(80),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            remarkWidget(),
          ],
        );

      case JsonSchemaType.file:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 16.0, top: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: Text(widget.question.title ?? ''),
                  ),
                  if (widget.question.description != null)
                    Text(
                      widget.question.description!,
                      style: widget.descriptionTextDecoration,
                    ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Stack(
                      alignment: Alignment.topRight,
                      children: [
                        SizedBox(
                          height: 70,
                          width: 100,
                          child: Icon(
                            Icons.add_a_photo_outlined,
                            color: Colors.grey[500],
                            size: 70,
                          ),
                        ),
                        widget.question.answer != null
                            ? const CircleAvatar(
                                backgroundColor: Colors.green,
                                radius: 15,
                                child: Icon(
                                  Icons.check,
                                  color: Colors.white,
                                ),
                              )
                            : const SizedBox.shrink(),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      String url = widget.imageUrl;
                      setState(() {
                        widget.question.answer = url;
                      });
                    },
                    child: const Padding(
                      padding: EdgeInsets.only(left: 5.0),
                      child: Text(
                        "Upload",
                        style: TextStyle(
                          color: Colors.black,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            remarkWidget(),
          ],
        );

      case JsonSchemaType.text:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 16.0, top: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: Text(widget.question.title ?? ''),
                  ),
                  if (widget.question.description != null)
                    Text(
                      widget.question.description!,
                      style: widget.descriptionTextDecoration,
                    ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 8.0,
                horizontal: 16,
              ),
              child: InputText(
                // validator: (value) => (widget.question.isMandatory ?? false) ? validateEmptyField(
                //                     value, 'Ingrese un ${widget.question.title} válido') : null,
                labelText: widget.question.title,
                maxLines: widget.question.maxline,
                onChanged: (value) {
                  setState(() {
                    widget.question.answer = value;
                  });
                },
              ),
            ),
            remarkWidget(),
          ],
        );

      default:
        return Container();
    }
  }

  Widget iconContainer(image) {
    return image == null
        ? Container()
        : Container(
            padding: const EdgeInsets.all(10),
            child: Image.asset(
              image,
              height: 20,
            ),
          );
  }

  Widget remarkWidget() {
    return widget.question.remark
        ? Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: TextCFirst(
                  widget.question.remarkTitle ?? 'Enter remarks',
                  fontWeight: FontWeight.bold,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8),
                child: Column(
                  children: [
                    InputText(
                      labelText: widget.question.remarkLabel ?? 'Enter the remark',
                      onChanged: (value) {
                        widget.question.remarkData = value;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),
            ],
          )
        : const SizedBox.shrink();
  }
}
