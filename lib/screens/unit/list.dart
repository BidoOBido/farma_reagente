import 'package:farma_reagente/components/route_navigator.dart';
import 'package:farma_reagente/constants/app_strings.dart';
import 'package:farma_reagente/database/app_database.dart';
import 'package:farma_reagente/models/unit.dart';
import 'package:farma_reagente/screens/common/list_base.dart';
import 'package:flutter/material.dart';
import 'package:internationalization/internationalization.dart';
import 'card.dart';

class UnitList extends StatefulWidget {
  final AppDatabase database;

  const UnitList({
    Key key,
    @required this.database,
  }) : super(key: key);

  @override
  _UnitListState createState() => _UnitListState();
}

class _UnitListState extends State<UnitList> {
  @override
  Widget build(BuildContext context) {
    RouteNavigatorList _navigatorList = RouteNavigatorList(context, actualName: 'name_unit_list');
    return ListBase(
      appBarName: Strings.of(context).valueOf('name_unit_list'),
      routeRegisterPage: AppStrings.routeUnitRegister,
      card: (Unit unit) => UnitCard(unit),
      navigatorList: _navigatorList,
      dao: widget.database.unitDAO,
    );
  }
}
