import 'package:farma_reagente/constants/app_strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:internationalization/internationalization.dart';

class RouteNavigatorItem {
  final String actualPageName;
  final String routeName;
  RouteNavigatorItem _next;
  RouteNavigatorItem _previous;

  RouteNavigatorItem(
    this.actualPageName,
    this.routeName,
  );

  set next(RouteNavigatorItem value) {
    this._next = value;
  }

  set previous(RouteNavigatorItem value) {
    this._previous = value;
  }

  RouteNavigatorItem get next {
    return this._next;
  }

  RouteNavigatorItem get previous {
    return this._previous;
  }
}

class RouteNavigatorList {
  final String actualName;

  List<RouteNavigatorItem> _routeNavigatorList = List();
  RouteNavigatorItem _actual;

  RouteNavigatorList(BuildContext context, {this.actualName}) {
    this._routeNavigatorList.add(
          RouteNavigatorItem(
            Strings.of(context).valueOf('name_unit_list'),
            AppStrings.routeUnitList,
          ),
        );
    this._routeNavigatorList.add(
          RouteNavigatorItem(
            Strings.of(context).valueOf('name_reagent_list'),
            AppStrings.routeReagentList,
          ),
        );
    this._routeNavigatorList.add(
          RouteNavigatorItem(
            Strings.of(context).valueOf('name_formula_list'),
            AppStrings.routeFormulaList,
          ),
        );

    switch (actualName) {
      case 'name_unit_list':
        _actual = _routeNavigatorList[0];
        break;
      case 'name_reagent_list':
        _actual = _routeNavigatorList[1];
        break;
      case 'name_formula_list':
        _actual = _routeNavigatorList[2];
        break;
    }

    for (RouteNavigatorItem _item in this._routeNavigatorList) {
      _item.next = this._routeNavigatorList[_nextId(_item)];
      _item.previous = this._routeNavigatorList[_previousId(_item)];
    }
  }

  RouteNavigatorItem getNext() {
    _actual = _actual.next;
    return _actual;
  }

  RouteNavigatorItem getPrevious() {
    _actual = _actual.previous;
    return _actual;
  }

  int _previousId(RouteNavigatorItem value) =>
      ((_routeNavigatorList.indexOf(value) - 1) % this._routeNavigatorList.length);

  int _nextId(RouteNavigatorItem value) => ((_routeNavigatorList.indexOf(value) + 1) % this._routeNavigatorList.length);
}
