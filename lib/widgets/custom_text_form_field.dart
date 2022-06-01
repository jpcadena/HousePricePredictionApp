import 'package:flutter/material.dart';

List myList = ["GarageYrBlt", "YearBuilt", "GarageCars", "OverallQual"];

class CustomTextFormField extends StatelessWidget {
  final String? hintText;
  final String? labelText;
  final String? helperText;
  final IconData? icon;
  final TextInputType? keyboardType;
  final bool obscureText;
  final String formProperty;
  final Map<String, double> formValues;

  const CustomTextFormField({
    Key? key,
    this.hintText,
    this.labelText,
    this.helperText,
    this.icon,
    this.keyboardType,
    this.obscureText = false,
    required this.formProperty,
    required this.formValues,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        obscureText: obscureText,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          hintText: hintText,
          labelText: labelText,
          helperText: helperText,
          //suffixIcon: Icon(Icons.verified_user),
          prefixIcon: icon == null ? null : Icon(icon),
          //icon: Icon(Icons.ac_unit_outlined),
        ),
        autovalidateMode: AutovalidateMode.onUserInteraction,
        initialValue: '',
        //autofocus: true,
        // if (myList.contains(formProperty)) int.parse(value) : 0
        textCapitalization: TextCapitalization.words,
        onChanged: (value) => formValues[formProperty] =
            (value != "") ? double.parse(value) : 0.0,
        validator: (value) {
          if (value == null) return 'Campo requerido';
          return value.isEmpty ? 'Campo requerido' : null;
        });
  }
}
