# Simple Form Builder
[![pub package](https://img.shields.io/pub/v/simple_form_builder.svg)](https://pub.dev/packages/simple_json_form)
[![Platform](https://img.shields.io/badge/Platform-Android%20%7C%20IOS%20%7C%20Web-green)](https://img.shields.io/badge/Platform-Android%20%7C%20IOS%20%7C%20Web-green)


A complete form builder for all your needs is still under construction, this project was based on the following repositories:

Simple Json Builder : [Tanmoy Karmakar](https://github.com/tanmoy27112000/SimpleFormBuilder)<br>
Json Schema Form: [Instituto Iracema](https://github.com/Instituto-Iracema/flutter_json_schema_form)<br>

### Specs
This library allows you to create a complete form from a json file with
multiple types of fields `text` , `checkbox`, `multiselect` , `date` , `time`, `format1`.
This package also provides additional remark options.

It has been written **100% in Dart**. ❤️

<br>

## Installing
Add the following to your `pubspec.yaml` file:
```yaml
dependencies:
  simple_json_form: ^0.0.3
```

<br>


<br>

## Simple Usage

To integrate the Simple form builder all you need to do is follow the given JSON schema and pass it to the formBuilder widget

### JSON Schema

```dart

// The complete sample is provided in the global folder that can be used as a reference

  //multiple (option button)
  {
    "form": [
      {
        "key": "informations",
        "properties": [
          "key": "identifier",
          "fields": ["1", "2", "3", "4", "5"],
          "title": "This is my title",
          "description": "This is my description",
          "type": "multiple",
        ]
      }
    ]
  }

  //checkbox
  {
    "form": [
      {
        "key": "informations",
        "properties": [
          "key": "identifier",
          "fields": ["1", "2", "3", "4", "5"],
          "title": "This is my title",
          "description": "This is my description",
          "type": "checkbox"
        ]
      }
    ]
  }

  //text - number
  {
    "form": [
      {
        "key": "informations",
        "properties": [
          "key": "identifier",
          "title": "This is my title",
          "description": "This is my description",
          "type": "text",
          "is_mandatory": false,
          "readOnly": true,
          "validations": {
                "message": "This is my message",
            "length": {"min": 10, "max": 20},
          }
        ]
      }
    ]
  }

  //date
  {
    "form": [
      {
        "key": "informations",
        "properties": [
          "key": "identifier",
          "title": "This is my title",
          "description": "This is my description",
          "type": "date",
          "is_mandatory": false,
        ]
      }
    ]
  }

  //time
  {
    "form": [
      {
        "key": "informations",
        "properties": [
          "key": "identifier_boat",
          "title": "This is my title",
          "description": "This is my description",
          "type": "time",
          "is_mandatory": false,
        ]
      }
    ]
  }

  //format1
  {
    "form": [
      {
        "key": "informations",
        "properties": [
          "key": "identifier_boat",
          "fields": ["1", "2", "3", "4", "5"],
          "title": "This is my title",
          "description": "This is my description",
          "type": "format1",
          "raw": [
            {
              "title": "Menu 1",
              "description": "description 1",
              "properties": [
                {
                  "key": "key_date",
                  "title": "date",
                  "type": "date",
                },
              ]
            },
            {
              "title": "Menu 2",
              "properties": [
                {
                  "key": "key_trips",
                  "title": "Trips",
                  "type": "text",
                },
              ]
            },
          ]
        ]
      }
    ]
  }

```
<br>

### Widget Implementation

```dart
import 'dart:convert';

import 'package:example/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:simple_json_form/simple_json_form.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //theme: ThemeData.dark(),
      title: 'FormBuilder Example',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Material App Bar'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SimpleJsonForm(
                jsonSchema: sampleData,
                title: "EVALUACION DE DESEMPEÑO DEL PERSONAL EMBARCADO",
                titleStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
                description: "EVALUACION DE DESEMPEÑO",
                crossAxisAlignment: CrossAxisAlignment.center,
                index: 0,
                imageUrl: '',
                defaultValues: DefaultValues().copyWith(
                  nextButtonText: 'Siguiente',
                  hintDropdownText: 'Elija una opcion',
                  previousButtonText: 'Anterior',
                  submitButtonText: 'Enviar',
                  validationDescription: 'Algunos campos requeridos faltan',
                  validationTitle: 'Fallo validaciones',
                  fieldRequired: 'campo es requerido',
                ),
                descriptionStyleText: const TextStyle(
                  color: Colors.lightBlue,
                ),
                titleStyleText: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.blue,
                ),
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
| `index`                 | If the data contains mutiple forms passing the index of the form will show the question of that perticular form |
| `onSubmit`              | This function will take in the map value and pass it to the given function when submit button is pressed |
| `loading`               | widget to use loading form |
| `defaultValues`         | model to use with values default in form |
<br>