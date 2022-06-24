import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:simple_json_form/simple_json_form.dart';
import 'package:simple_json_form/src/controller/simple_json_form_controller.dart';
import 'package:simple_json_form/src/utils/constants.dart';
import 'package:simple_json_form/src/utils/form.dart';
import 'package:simple_json_form/src/utils/responsive.dart';
import 'package:simple_json_form/src/utils/utils.dart';
import 'package:simple_json_form/src/widgets/input_text.dart';
import 'package:simple_json_form/src/widgets/simple_json_form_remark.dart';

class SimpleJsonFormField extends StatefulWidget {
  const SimpleJsonFormField({
    Key? key,
    required this.properties,
    required this.imageUrl,
    required this.hintDropdownText,
    this.descriptionStyleText,
    this.titleStyleText,
  }) : super(key: key);

  final Properties properties;
  final String imageUrl;
  final TextStyle? descriptionStyleText;
  final TextStyle? titleStyleText;
  final String hintDropdownText;

  @override
  State<SimpleJsonFormField> createState() => _SimpleJsonFormFieldState();
}

class _SimpleJsonFormFieldState extends State<SimpleJsonFormField> {
  @override
  Widget build(BuildContext context) {
    switch (widget.properties.type) {
      case JsonSchemaType.multiple:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 16.0, top: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (widget.properties.title != null)
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: Text(
                        widget.properties.title!,
                        style: widget.titleStyleText,
                      ),
                    ),
                  if (widget.properties.description != null)
                    Text(
                      widget.properties.description!,
                      style: widget.descriptionStyleText,
                    ),
                ],
              ),
            ),
            ...widget.properties.fields!.map(
              (entry) => RadioListTile(
                value: entry,
                groupValue: widget.properties.answer,
                title: Text(
                  entry,
                  style: TextStyle(
                    color: widget.properties.answer != entry
                        ? Colors.grey
                        : Colors.black,
                    fontWeight: FontWeight.normal,
                    fontSize: Responsive.of(context).dp(1.8),
                  ),
                ),
                onChanged: (value) {
                  widget.properties.answer = value;
                  setState(() {});
                },
              ),
            ),
            widget.properties.remark
                ? SimpleJsonFormRemark(
                    properties: widget.properties,
                  )
                : const SizedBox.shrink(),
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
                  if (widget.properties.title != null)
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: Text(
                        widget.properties.title!,
                        style: widget.titleStyleText,
                      ),
                    ),
                  if (widget.properties.description != null)
                    Text(
                      widget.properties.description!,
                      style: widget.descriptionStyleText,
                    ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 8.0,
                horizontal: 16,
              ),
              child: DropdownButtonFormField(
                iconEnabledColor: Constants.lightBlueColor,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Constants.lightBlueColor, width: 0.0),
                  ),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Constants.lightBlueColor)),
                ),
                hint: Text(widget.hintDropdownText),
                items: widget.properties.fields!.map(
                  (val) {
                    return DropdownMenuItem<String>(
                      value: val,
                      child: Text(val),
                    );
                  },
                ).toList(),
                onChanged: (value) {
                  setState(() {
                    widget.properties.answer = value;
                  });
                },
              ),
            ),
            widget.properties.remark
                ? SimpleJsonFormRemark(
                    properties: widget.properties,
                  )
                : const SizedBox.shrink(),
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
                  if (widget.properties.title != null)
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: Text(
                        widget.properties.title!,
                        style: widget.titleStyleText,
                      ),
                    ),
                  if (widget.properties.description != null)
                    Text(
                      widget.properties.description!,
                      style: widget.descriptionStyleText,
                    ),
                ],
              ),
            ),
            ...widget.properties.fields!.map(
              (entry) => CheckboxListTile(
                controlAffinity: ListTileControlAffinity.leading,
                dense: true,
                title: Text(
                  entry,
                  style: TextStyle(
                    color: widget.properties.answer[
                                widget.properties.fields!.indexOf(entry)] !=
                            true
                        ? Colors.grey
                        : Colors.black,
                    fontWeight: FontWeight.normal,
                    fontSize: Responsive.of(context).dp(1.8),
                  ),
                ),
                value: widget.properties
                    .answer[widget.properties.fields!.indexOf(entry)],
                onChanged: (value) {
                  widget.properties
                      .answer[widget.properties.fields!.indexOf(entry)] = value;
                  setState(() {});
                },
              ),
            ),
            widget.properties.remark
                ? SimpleJsonFormRemark(
                    properties: widget.properties,
                  )
                : const SizedBox.shrink(),
          ],
        );

      case JsonSchemaType.time:
        final controller =
            SimpleJsonFormController.getKeyController(widget.properties.key);
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 8.0,
                horizontal: 16,
              ),
              child: InputText(
                controller: controller,
                readOnly: true,
                onTap: () => selectTime(context, controller),
                validator: widget.properties.isMandatory
                    ? (value) => validateEmptyFieldWithLength(
                          value,
                          widget.properties.validations?.length?.min ?? 1,
                          widget.properties.validations?.length?.max ?? 100,
                          widget.properties.validations?.message ??
                              'Field is required',
                        )
                    : null,
                labelText: widget.properties.description,
                maxLines: widget.properties.maxline,
                onChanged: (value) {
                  widget.properties.answer = value;
                },
                title: widget.properties.title,
              ),
            ),
            widget.properties.remark
                ? SimpleJsonFormRemark(
                    properties: widget.properties,
                  )
                : const SizedBox.shrink(),
          ],
        );

      case JsonSchemaType.date:
        final controller =
            SimpleJsonFormController.getKeyController(widget.properties.key);
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 8.0,
                horizontal: 16,
              ),
              child: InputText(
                controller: controller,
                readOnly: true,
                onTap: () => selectDate(context, controller),
                validator: widget.properties.isMandatory
                    ? (value) => validateEmptyFieldWithLength(
                          value,
                          widget.properties.validations?.length?.min ?? 1,
                          widget.properties.validations?.length?.max ?? 100,
                          widget.properties.validations?.message ??
                              'Field is required',
                        )
                    : null,
                labelText: widget.properties.description,
                maxLines: widget.properties.maxline,
                onChanged: (value) {
                  widget.properties.answer = value;
                },
                title: widget.properties.title,
              ),
            ),
            widget.properties.remark
                ? SimpleJsonFormRemark(
                    properties: widget.properties,
                  )
                : const SizedBox.shrink(),
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
                  if (widget.properties.title != null)
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: Text(
                        widget.properties.title!,
                        style: widget.titleStyleText,
                      ),
                    ),
                  if (widget.properties.description != null)
                    Text(
                      widget.properties.description!,
                      style: widget.descriptionStyleText,
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
                        widget.properties.answer != null
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
                        widget.properties.answer = url;
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
            widget.properties.remark
                ? SimpleJsonFormRemark(
                    properties: widget.properties,
                  )
                : const SizedBox.shrink(),
          ],
        );

      case JsonSchemaType.text:
        final controller =
            SimpleJsonFormController.getKeyController(widget.properties.key);
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 8.0,
                horizontal: 16,
              ),
              child: InputText(
                controller: controller,
                validator: widget.properties.isMandatory
                    ? (value) => validateEmptyFieldWithLength(
                          value,
                          widget.properties.validations?.length?.min ?? 1,
                          widget.properties.validations?.length?.max ?? 100,
                          widget.properties.validations?.message ??
                              'Field is required',
                        )
                    : null,
                labelText: widget.properties.description,
                title: widget.properties.title,
                maxLines: widget.properties.maxline,
                onChanged: (value) {
                  //setState(() {
                  widget.properties.answer = value;
                  //});
                },
              ),
            ),
            widget.properties.remark
                ? SimpleJsonFormRemark(
                    properties: widget.properties,
                  )
                : const SizedBox.shrink(),
          ],
        );

      default:
        return Container();
    }
  }

  selectDate(BuildContext context, TextEditingController? controller) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(), // Refer step 1
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(hours: 43800)),
    );

    if (picked == null) return;
    controller?.text = DateFormat('dd-MM-yyyy').format(picked);
    widget.properties.answer = picked;
  }

  selectTime(BuildContext context, TextEditingController? controller) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked == null) return;
    final formatTime = formatTimeOfDay(picked);
    controller?.text = formatTime;
    widget.properties.answer = picked;
  }
}
