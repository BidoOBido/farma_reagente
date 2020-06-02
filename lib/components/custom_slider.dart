import 'package:farma_reagente/components/custom_title.dart';
import 'package:farma_reagente/constants/styles.dart';
import 'package:flutter/material.dart';

class CustomSlider extends StatelessWidget {
  final String label;
  final int value;
  final double min;
  final double max;
  final Function(double) onChanged;

  const CustomSlider({
    Key key,
    @required this.label,
    @required this.value,
    @required this.min,
    @required this.max,
    @required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: Styles.paddingVerticalSymmetric,
      child: Column(
        children: <Widget>[
          CustomTitle(text: label),
          Padding(
            padding: Styles.paddingVerticalOnly,
            child: Slider(
              value: value.toDouble(),
              min: min,
              max: max,
              activeColor: Theme.of(context).primaryColor,
              inactiveColor: Colors.grey,
              label: '$value',
              divisions: (max - min).round(),
              onChanged: (double newValue) => onChanged(newValue),
            ),
          ),
        ],
      ),
    );
  }
}
