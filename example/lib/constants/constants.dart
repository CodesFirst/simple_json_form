import 'package:simple_json_form/simple_json_form.dart';

final sampleData = JsonSchema.fromJson({
  "form": [
    {
      "key": "informations",
      "properties": [
        {
          "key": "date",
          "title": "Fecha",
          "type": "date",
        },
        {
          "key": "bp",
          "title": "BP",
          "type": "text",
        },
      ]
    },
    {
      "key": "table",
      "properties": [
        {
          "key": "table_dynamic",
          "title": "Listado",
          "type": "format1",
          "raw": [
            {
              "title": "Menu 1",
              "description": "Llenado de cubas",
              "properties": [
                {
                  "key": "key_text2",
                  "title": "Title text",
                  "type": "text",
                },
              ]
            },
            {
              "title": "Menu 2",
              "properties": [
                {
                  "key": "date2",
                  "title": "Date of title",
                  "type": "text",
                },
              ]
            },
          ]
        },
      ]
    },
  ]
});
