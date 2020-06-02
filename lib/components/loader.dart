import 'package:flutter/material.dart';
import 'package:internationalization/internationalization.dart';

class Loader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          CircularProgressIndicator(),
          Text(Strings.of(context).valueOf('message_loading')),
        ],
      ),
    );
  }
}
