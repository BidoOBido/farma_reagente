import 'package:farma_reagente/components/route_navigator.dart';
import 'package:farma_reagente/constants/app_strings.dart';
import 'package:farma_reagente/database/app_database.dart';
import 'package:farma_reagente/models/formula.dart';
import 'package:farma_reagente/screens/common/list_base.dart';
import 'package:flutter/material.dart';
import 'package:internationalization/internationalization.dart';

import 'card.dart';

class FormulaList extends StatefulWidget {
  final AppDatabase database;

  const FormulaList({
    Key key,
    @required this.database,
  }) : super(key: key);

  @override
  _FormulaListState createState() => _FormulaListState();
}

class _FormulaListState extends State<FormulaList> {
  @override
  Widget build(BuildContext context) {
    RouteNavigatorList _navigatorList = RouteNavigatorList(context, actualName: 'name_formula_list');
    return ListBase(
      appBarName: Strings.of(context).valueOf('name_formula_list'),
      routeRegisterPage: AppStrings.routeFormulaRegister,
      card: (Formula formula) => FormulaCard(formula),
      navigatorList: _navigatorList,
      dao: widget.database.formulaDAO,
    );
  }
}
