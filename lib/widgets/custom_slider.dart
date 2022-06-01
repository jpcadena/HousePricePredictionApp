import 'package:flutter/material.dart';

class CustomSlider extends StatefulWidget {
  const CustomSlider({
    Key? key,
    required this.sendValues,
    required this.min,
    required this.max,
    this.divisions,
    required this.property,
    required this.label,
  }) : super(key: key);

  final Map<String, double> sendValues;
  final double min;
  final double max;
  final int? divisions;
  final String property;
  final String label;

  @override
  State<CustomSlider> createState() => _CustomSliderState();
}

class _CustomSliderState extends State<CustomSlider> {
  double _value = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('${widget.label}: ${_value.toString()}'),
        Slider(
            activeColor: Colors.indigo,
            value: _value,
            min: widget.min,
            max: widget.max,
            divisions: widget.divisions ?? 0,
            onChanged: (value) {
              _value = value;
              widget.sendValues[widget.property] = value;
              setState(() {});
            }),
      ],
    );
  }
}
