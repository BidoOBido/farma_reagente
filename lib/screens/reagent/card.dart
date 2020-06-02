import 'package:farma_reagente/constants/app_strings.dart';
import 'package:farma_reagente/models/reagent.dart';
import 'package:flutter/material.dart';

class ReagentCard extends StatelessWidget {
  final Reagent reagent;

  const ReagentCard(
    this.reagent, {
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(reagent.description),
        onTap: () {
          Navigator.pushReplacementNamed(
            context,
            AppStrings.routeReagentRegister,
            arguments: reagent,
          );
        },
      ),
      elevation: 2,
    );
  }
}
