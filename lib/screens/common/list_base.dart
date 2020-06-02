import 'package:emojis/emojis.dart';
import 'package:farma_reagente/components/future_builder_handler.dart';
import 'package:farma_reagente/components/navigation_button.dart';
import 'package:farma_reagente/components/route_navigator.dart';
import 'package:farma_reagente/components/screen_size_reducers.dart';
import 'package:farma_reagente/constants/styles.dart';
import 'package:farma_reagente/dao/dao.dart';
import 'package:flutter/material.dart';
import 'package:internationalization/internationalization.dart';

class ListBase<T> extends StatelessWidget {
  final String appBarName;
  final Widget Function(T element) card;
  final String routeRegisterPage;
  final RouteNavigatorList navigatorList;
  final DAO dao;

  const ListBase({
    Key key,
    @required this.appBarName,
    @required this.card,
    @required this.routeRegisterPage,
    @required this.dao,
    @required this.navigatorList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          appBarName,
          style: Styles.whiteText,
        ),
      ),
      body: FutureBuilderHandler<T>(
        future: dao.findAll(),
        done: (data) => _done(data, context),
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 16.0,
        shape: const CircularNotchedRectangle(),
        color: Colors.green[400],
        child: Row(
          children: <Widget>[
            Container(
              height: 50.0,
              width: percentageScreenWidth(context, percentage: 0.4),
              child: NavigationButtonPrevious(
                onPressed: () => _goTo(context, navigatorList.getPrevious().routeName),
                label: navigatorList.getPrevious().actualPageName,
              ),
            ),
            Container(
              height: 50.0,
              width: percentageScreenWidth(context, percentage: 0.2),
            ),
            Container(
              height: 50.0,
              width: percentageScreenWidth(context, percentage: 0.4),
              child: NavigationButtonNext(
                onPressed: () => _goTo(context, navigatorList.getNext().routeName),
                label: navigatorList.getNext().next.actualPageName,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushReplacementNamed(
            context,
            routeRegisterPage,
          );
        },
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  _goTo(BuildContext context, String routeName) {
    Navigator.pushReplacementNamed(
      context,
      routeName,
    );
  }

  Widget _done(List<T> data, BuildContext context) {
    final List<T> list = data;
    if (list.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              Emojis.manDetective,
              style: TextStyle(
                fontSize: 24.0,
              ),
            ),
            Text(Strings.of(context).valueOf('message_no_record_found')),
          ],
        ),
      );
    } else {
      return ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, index) {
          return card(list[index]);
        },
      );
    }
  }
}
