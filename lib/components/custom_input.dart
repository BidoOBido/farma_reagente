import 'package:farma_reagente/components/custom_title.dart';
import 'package:farma_reagente/constants/styles.dart';
import 'package:flutter/material.dart';

class CustomInput extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final int maxLenght;
  final String Function(String) validator;
  final String hint;
  final Icon icon;
  final TextInputType keyboardType;

  const CustomInput({
    Key key,
    @required this.label,
    @required this.controller,
    @required this.maxLenght,
    this.validator,
    this.hint,
    this.icon,
    this.keyboardType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: Styles.paddingVerticalSymmetric,
      child: Column(
        children: <Widget>[
          CustomTitle(
            text: label,
          ),
          TextFormField(
            textAlign: TextAlign.justify,
            controller: controller,
            decoration: InputDecoration(
              icon: icon,
              hintText: hint,
              counterText: keyboardType == TextInputType.multiline ? null : '',
            ),
            keyboardType: keyboardType,
            validator: validator,
            maxLines: keyboardType == TextInputType.multiline ? 5 : null,
            maxLength: maxLenght,
          ),
        ],
      ),
    );
  }
}
