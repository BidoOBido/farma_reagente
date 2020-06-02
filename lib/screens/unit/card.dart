import 'package:farma_reagente/constants/app_strings.dart';
import 'package:farma_reagente/models/unit.dart';
import 'package:flutter/material.dart';

class UnitCard extends StatelessWidget {
  final Unit unit;

  const UnitCard(
    this.unit, {
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String decimalPlaces = unit.precision.toString();
    return Card(
      child: ListTile(
        leading: Icon(UnitType.values[unit.unitTypeID] == UnitType.solid ? Icons.category : Icons.colorize),
        title: Text(unit.description),
        subtitle: Text('Precisão de $decimalPlaces casas decimais.'),
        onTap: () {
          Navigator.pushReplacementNamed(
            context,
            AppStrings.routeUnitRegister,
            arguments: unit,
          );
        },
      ),
      elevation: 2,
    );
  }
}
