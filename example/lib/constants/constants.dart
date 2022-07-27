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
        {
          "key": "trips",
          "title": "Viaje",
          "type": "text",
        },
        {
          "key": "fulfilled",
          "title": "Cumplimiento del trabajo",
          "type": "multiple",
          "fields": ["CUMPLIDO", "NO CUMPLIDO"],
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
                  "key": "cuba1",
                  "title": "Cuba",
                  "type": "text",
                },
                {
                  "key": "washed1",
                  "title": "Lavado",
                  "type": "text",
                },
                {
                  "key": "executedBy1",
                  "title": "Ejecutado por",
                  "type": "text",
                },
                {
                  "key": "responsible1",
                  "title": "Responsable",
                  "type": "text",
                },
              ]
            },
            {
              "title": "Menu 2",
              "properties": [
                {
                  "key": "cuba2",
                  "title": "Cuba",
                  "type": "text",
                },
                {
                  "key": "washed2",
                  "title": "Lavado",
                  "type": "text",
                },
                {
                  "key": "executedBy2",
                  "title": "Ejecutado por",
                  "type": "text",
                },
                {
                  "key": "responsible2",
                  "title": "Responsable",
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
