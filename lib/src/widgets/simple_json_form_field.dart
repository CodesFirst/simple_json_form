import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:simple_json_form/simple_json_form.dart';
import 'package:simple_json_form/src/controller/simple_json_form_controller.dart';
import 'package:simple_json_form/src/utils/constants.dart';
import 'package:simple_json_form/src/utils/form.dart';
import 'package:simple_json_form/src/utils/responsive.dart';
import 'package:simple_json_form/src/utils/utils.dart';
import 'package:simple_json_form/src/widgets/input_text.dart';

class SimpleJsonFormField extends StatefulWidget {
  const SimpleJsonFormField({
    Key? key,
    required this.properties,
    required this.imageUrl,
    required this.hintDropdownText,
    required this.isRTL,
    this.descriptionStyleText,
    this.titleStyleText,
  }) : super(key: key);

  final Properties properties;
  final String imageUrl;
  final TextStyle? descriptionStyleText;
  final TextStyle? titleStyleText;
  final String hintDropdownText;
  final bool isRTL;

  @override
  State<SimpleJsonFormField> createState() => _SimpleJsonFormFieldState();
}

class _SimpleJsonFormFieldState extends State<SimpleJsonFormField> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

// used here to be static or render one time
  TextEditingController controller = TextEditingController();

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
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: Text(
                      widget.properties.title,
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
            // widget.properties.remark
            //     ? SimpleJsonFormRemark(
            //         properties: widget.properties,
            //       )
            //     : const SizedBox.shrink(),
          ],
        );
      case JsonSchemaType.dropdown:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 20.0, top: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: Text(
                      widget.properties.title,
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
                horizontal: 20.0,
              ),
              child: DropdownButtonFormField(
                iconEnabledColor: Constants.purpleColor,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Constants.purpleColor, width: 0.0),
                  ),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Constants.purpleColor)),
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
            // widget.properties.remark
            //     ? SimpleJsonFormRemark(
            //         properties: widget.properties,
            //       )
            //     : const SizedBox.shrink(),
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
                    child: Text(
                      widget.properties.title,
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
            // widget.properties.remark
            //     ? SimpleJsonFormRemark(
            //         properties: widget.properties,
            //       )
            //     : const SizedBox.shrink(),
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
                isRTL: widget.isRTL,
                controller: controller,
                readOnly: true,
                onTap: () => selectTime(context, controller),
                validator: widget.properties.isRequired
                    ? (value) => validateEmptyFieldWithLength(
                          value,
                          widget.properties.validations?.length.min ?? 1,
                          widget.properties.validations?.length.max ?? 100,
                          widget.properties.validations?.message ??
                              'Field is required',
                        )
                    : null,
                labelText: widget.properties.description,
                maxLines: widget.properties.maxLine,
                onChanged: (value) {
                  widget.properties.answer = value;
                },
                title: widget.properties.title,
              ),
            ),
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
                isRTL: widget.isRTL,
                controller: controller,
                readOnly: true,
                onTap: () => selectDate(context, controller),
                validator: widget.properties.isRequired
                    ? (value) => validateEmptyFieldWithLength(
                          value,
                          widget.properties.validations?.length.min ?? 1,
                          widget.properties.validations?.length.max ?? 100,
                          widget.properties.validations?.message ??
                              'Field is required',
                        )
                    : null,
                labelText: widget.properties.description,
                maxLines: widget.properties.maxLine,
                onChanged: (value) {
                  widget.properties.answer = value;
                },
                title: widget.properties.title,
              ),
            ),
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
                    child: Text(
                      widget.properties.title,
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
          ],
        );

      case JsonSchemaType.number:
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
                isRTL: widget.isRTL,
                controller: controller,
                keyboardType: TextInputType.number,
                validator: widget.properties.isRequired
                    ? (value) => validateEmptyFieldWithLength(
                          value,
                          widget.properties.validations?.length.min ?? 1,
                          widget.properties.validations?.length.max ?? 100,
                          widget.properties.validations?.message ??
                              'Field is required',
                        )
                    : null,
                labelText: widget.properties.description,
                title: widget.properties.title,
                readOnly: widget.properties.readOnly,
                maxLines: widget.properties.maxLine,
                onChanged: (value) {
                  //setState(() {
                  widget.properties.answer = value;
                  //});
                },
              ),
            ),
            // widget.properties.remark
            //     ? SimpleJsonFormRemark(
            //         properties: widget.properties,
            //       )
            //     : const SizedBox.shrink(),
          ],
        );

      case JsonSchemaType.text:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 8.0,
                horizontal: 16,
              ),
              child: InputText(
                isRTL: widget.isRTL,
                controller: controller,
                validator: widget.properties.isRequired
                    ? (value) => validateEmptyFieldWithLength(
                          value,
                          widget.properties.validations?.length.min ?? 1,
                          widget.properties.validations?.length.max ?? 100,
                          widget.properties.validations?.message ??
                              'Field is required',
                        )
                    : null,
                labelText: widget.properties.description,
                title: widget.properties.title,
                maxLines: widget.properties.maxLine,
                readOnly: widget.properties.readOnly,
                onChanged: (value) {
                  //setState(() {
                  widget.properties.answer = value;
                  //});
                },
              ),
            ),
            // widget.properties.remark
            //     ? SimpleJsonFormRemark(
            //         properties: widget.properties,
            //       )
            //     : const SizedBox.shrink(),
          ],
        );
      case JsonSchemaType.format1:
        final raw = widget.properties.raw;
        if (raw == null) return const SizedBox.shrink();
        List<Widget> widgetFormat1 = [];
        int index = 1;
        for (var entry in raw) {
          List<Widget> widgetTemp = [];
          for (Properties property in entry.properties) {
            widgetTemp.add(SimpleJsonFormField(
              properties: property,
              imageUrl: widget.imageUrl,
              descriptionStyleText: widget.descriptionStyleText,
              titleStyleText: widget.titleStyleText,
              hintDropdownText: widget.hintDropdownText,
              isRTL: widget.isRTL,
            ));
          }
          widgetFormat1.add(
            ExpansionTile(
              title: Text(
                entry.title,
                style: widget.titleStyleText,
              ),
              subtitle: Text(
                entry.description ?? '',
                style: widget.descriptionStyleText,
              ),
              controlAffinity: ListTileControlAffinity.leading,
              children: <Widget>[...widgetTemp],
            ),
          );
        }

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Column(
            children: [...widgetFormat1],
          ),
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
