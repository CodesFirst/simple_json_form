import 'package:flutter/material.dart';
import 'package:simple_json_form/src/utils/constants.dart';
import 'package:simple_json_form/src/widgets/text_cfirst.dart';

class CustomDropdownWidget extends StatelessWidget {
  const CustomDropdownWidget({
    Key? key,
    required this.onChanged,
    required this.title,
    required this.width,
    this.isRequired = true,
    this.droplist,
    this.dropVal,
    this.onTap,
  }) : super(key: key);

  final Function onChanged;
  final String title;
  final double width;
  final bool isRequired;
  final List? droplist;
  final String? dropVal;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Stack(
          children: [
            SizedBox(
              width: width,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownButtonFormField(
                  iconEnabledColor: Constants.lightBlueColor,
                  icon: const RotatedBox(
                    quarterTurns: 3,
                    child: Icon(
                      Icons.arrow_back_ios_rounded,
                      size: 20,
                      color: Colors.grey,
                    ),
                  ),
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Constants.lightBlueColor, width: 0.0),
                    ),
                    border: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Constants.lightBlueColor)),
                  ),
                  value: dropVal,
                  hint: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      isRequired
                          ? const TextCFirst(
                              "* ",
                              fontWeight: FontWeight.bold,
                              colorText: Colors.red,
                            )
                          : const SizedBox.shrink(),
                      TextCFirst(
                        title,
                        colorText: onTap != null
                            ? Constants.grayColor
                            : Constants.grayLightColor,
                      ),
                    ],
                  ),
                  isExpanded: true,
                  iconSize: 30.0,
                  // style: TextStyle(
                  //   color: Colors.black,
                  // ),
                  items: droplist != null
                      ? droplist!.map(
                          (val) {
                            return DropdownMenuItem<String>(
                              value: val,
                              child: Text(val),
                            );
                          },
                        ).toList()
                      : ['All', 'Two', 'Three'].map(
                          (val) {
                            return DropdownMenuItem<String>(
                              value: val,
                              child: Text(val),
                            );
                          },
                        ).toList(),
                  onChanged: (val) {
                    onChanged(val);
                  },
                ),
              ),
            ),
            onTap == null
                ? const SizedBox.shrink()
                : InkWell(
                    onTap: () => onTap!(),
                    child: SizedBox(
                      width: width,
                      height: 50,
                    ),
                  )
          ],
        ),
      ],
    );
  }
}
