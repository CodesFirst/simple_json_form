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
