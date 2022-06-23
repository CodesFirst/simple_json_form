# Simple Form Builder
[![pub package](https://img.shields.io/pub/v/simple_form_builder.svg)](https://pub.dev/packages/simple_json_form)
[![Platform](https://img.shields.io/badge/Platform-Android%20%7C%20IOS%20%7C%20Web-green)](https://img.shields.io/badge/Platform-Android%20%7C%20IOS%20%7C%20Web-green)


A complete form builder for all your needs is still under construction, this project was based on the following repositories:

Simple Json Builder : [Tanmoy Karmakar](https://github.com/tanmoy27112000/SimpleFormBuilder)<br>
Json Schema Form: [Instituto Iracema](https://github.com/Instituto-Iracema/flutter_json_schema_form)<br>

### Specs
This library allows you to create a complete form from a json file with
multiple types of fields `text` , `checkbox`, `multiselect` , `date` , `time`.
This package also provides additional remark options.

It has been written **100% in Dart**. ❤️

<br>

## Installing
Add the following to your `pubspec.yaml` file:
```yaml
dependencies:
  simple_json_form: ^0.0.1
```

<br>


<br>

## Simple Usage

To integrate the Simple form builder all you need to do is follow the given JSON schema and pass it to the formBuilder widget

### JSON Schema

```dart

// The complete sample is provided in the global folder that can be used as a reference

{
  "form": [
	{
	  "key": "questions",
	  "properties": [
	    {
	      "key": "identifier_boat",
	      "fields": ["1", "2", "3", "4", "5"],
	      "title": "This is my title",
	      "description": "This is my description",
	      "remark": true,
	      "remark_label": "points",
	      "remark_title": "insert to points",
	      "type": "multiple",
	      "direction": "",
	      "is_mandatory": false,
	      "validations": {
              "message": "This is my message",
		      "length": {"min": 10, "max": 20}
	      }
	    },
	  ]
	},
  ]
}

```
<br>

### Widget Implementation

```dart
import 'package:flutter/material.dart';
import 'package:simple_form_builder/formbuilder.dart';
import 'package:simple_form_builder/global/constant.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Json Form Example',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Material App Bar'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SimpleJsonForm(
                jsonSchema: sampleData,
                title: "My Title",
                titleStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
                description: "My description",
                crossAxisAlignment: CrossAxisAlignment.center,
                index: 0,
                imageUrl: fileUpload(),
                submitButtonText: 'Send',
                nextButtonText: 'Next',
                previousButtonText: 'Previous',
                onSubmit: (val) {
                  if (val == null) {
                    print("no data");
                  } else {
                    var json = jsonEncode(val.toJson());
                    print(json);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
```
<br>

## Custom Usage
There are several options that allow for more control:

|  Properties  |   Description   |
|--------------|-----------------|
| `jsonSchema`            | JSON Schema to use to generate the form.
| `crossAxisAlignment`    | crossAxisAlignment to use general form |
| `padding`               | padding to use general form |
| `title`                 | Title general to use the form |
| `titleStyle`            | title style to use title the form |
| `description`           | Description general to use the form |
| `descriptionStyle`      | Description style to use description form |
| `submitButtonText`      | To use for text the submit button |
| `previousButtonText`    | To use for text the previous button |
| `nextButtonText`        |  To use for text the next button |
| `index`                 | If the data contains mutiple forms passing the index of the form will show the question of that perticular form |
| `onSubmit`              | This function will take in the map value and pass it to the given function when submit button is pressed |
| `loading`               | widget to use loading form |
| `validationTitle`       | text for use dialog info |
| `validationDescription` | text for use dialog info |

  
<br>