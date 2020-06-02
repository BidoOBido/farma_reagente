import 'package:farma_reagente/constants/app_strings.dart';
import 'package:farma_reagente/models/formula.dart';
import 'package:flutter/material.dart';

class FormulaCard extends StatelessWidget {
  final Formula formula;

  const FormulaCard(
    this.formula, {
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(formula.name),
        subtitle: Text(formula.description),
        onTap: () {
          Navigator.pushReplacementNamed(
            context,
            AppStrings.routeFormulaRegister,
            arguments: formula,
          );
        },
      ),
      elevation: 2,
    );
  }
}
