import 'package:farma_reagente/components/route_navigator.dart';
import 'package:farma_reagente/constants/app_strings.dart';
import 'package:farma_reagente/database/app_database.dart';
import 'package:farma_reagente/models/reagent.dart';
import 'package:farma_reagente/screens/common/list_base.dart';
import 'package:flutter/material.dart';
import 'package:internationalization/internationalization.dart';

import 'card.dart';

class ReagentList extends StatefulWidget {
  final AppDatabase database;

  const ReagentList({
    Key key,
    @required this.database,
  }) : super(key: key);

  @override
  _ReagentListState createState() => _ReagentListState();
}

class _ReagentListState extends State<ReagentList> {
  @override
  Widget build(BuildContext context) {
    RouteNavigatorList _navigatorList = RouteNavigatorList(context, actualName: 'name_reagent_list');
    return ListBase(
      appBarName: Strings.of(context).valueOf('name_reagent_list'),
      routeRegisterPage: AppStrings.routeReagentRegister,
      card: (Reagent reagent) => ReagentCard(reagent),
      navigatorList: _navigatorList,
      dao: widget.database.reagentDAO,
    );
  }
}
