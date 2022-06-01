import 'dart:convert';
import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:http/http.dart' as http;
import '../widgets/custom_text_form_field.dart';

class HouseInterface extends StatelessWidget {
  const HouseInterface({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Map<String, double> sendValues = {
      "BsmtFinSF1": 110,
      "GarageYrBlt": 200,
      "FrstFlrSF": 200,
      "GarageArea": 400,
      "TotalBsmtSF": 100,
      "YearBuilt": 99,
      "GarageCars": 8,
      "GrLivArea": 78,
      "OverallQual": 2
    };
    return Scaffold(
      appBar: AppBar(title: const Text('House Price Prediction')),
      body: Center(
          child: SingleChildScrollView(
              child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 0),
        child: Column(
          children: [
            CustomTextFormField(
                labelText: 'Basement finished area (Square feets)',
                hintText: '0.0',
                keyboardType: TextInputType.number,
                formProperty: 'BsmtFinSF1',
                formValues: sendValues),
            CustomTextFormField(
                labelText: 'Year garage was built',
                hintText: '0',
                keyboardType: TextInputType.number,
                formProperty: 'GarageYrBlt',
                formValues: sendValues),
            CustomTextFormField(
                labelText: 'First Floor square feet',
                hintText: '0.0',
                keyboardType: TextInputType.number,
                formProperty: 'FstFlrSF',
                formValues: sendValues),
            CustomTextFormField(
                labelText: 'Size of garage in square feet',
                hintText: '0.0',
                keyboardType: TextInputType.number,
                formProperty: 'GarageArea',
                formValues: sendValues),
            CustomTextFormField(
                labelText: 'Total square feet of basement area',
                hintText: '0.0',
                keyboardType: TextInputType.number,
                formProperty: 'TotalBsmtSF',
                formValues: sendValues),
            CustomTextFormField(
                labelText: 'Original construction date',
                hintText: '0',
                keyboardType: TextInputType.number,
                formProperty: 'YearBuilt',
                formValues: sendValues),
            CustomTextFormField(
                labelText: 'Size of garage in car capacity',
                hintText: '0',
                keyboardType: TextInputType.number,
                formProperty: 'GarageCars',
                formValues: sendValues),
            CustomTextFormField(
                labelText: 'Above grade (ground) living area square feet',
                hintText: '0.0',
                keyboardType: TextInputType.number,
                formProperty: 'GrLivArea',
                formValues: sendValues),
            CustomTextFormField(
                labelText:
                    'Rates the overall material and finish of the house [0:10]',
                hintText: '0',
                keyboardType: TextInputType.number,
                formProperty: 'OverallQual',
                formValues: sendValues),
            const SizedBox(height: 30),
            ElevatedButton(
                onPressed: () async {
                  final url =
                      Uri.http("127.0.0.1:5000", "/house-price-predictions");
                  final response = await http.post(url,
                      body: json.encode(sendValues),
                      headers: {
                        'Content-Type': "application/json; charset=utf-8"
                      });
                  print('Code Status: ${response.statusCode}');
                  print('Response Body: ${response.body}');
                  var salePrice = "";
                  if (response.statusCode == 201 ||
                      response.statusCode == 200) {
                    final Map jsonResponse = json.decode(response.body);
                    salePrice = jsonResponse['sale_price'].toString();
                  }
                  Alert(
                    context: context,
                    type: AlertType.success,
                    title: "",
                    desc: "El precio de la casa predicho es: \$" + salePrice,
                    buttons: [
                      DialogButton(
                        child: const Text(
                          "OK",
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ),
                        onPressed: () => Navigator.pop(context),
                        width: 120,
                      )
                    ],
                  ).show();
                },
                child: const SizedBox(
                    width: double.infinity,
                    child: Center(child: Text('Comprobar'))))
          ],
        ),
      ))),
    );
  }
}
