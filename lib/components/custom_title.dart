import 'package:flutter/material.dart';
import 'package:farma_reagente/constants/app_strings.dart';

class CustomTitle extends StatelessWidget {
  final String text;

  const CustomTitle({
    Key key,
    this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      child: Text(
        text == null ? AppStrings.emptyString : text,
        style: TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.w500,
          color: Theme.of(context).primaryColor,
        ),
      ),
    );
  }
}
