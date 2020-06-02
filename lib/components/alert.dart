import 'package:farma_reagente/constants/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:internationalization/internationalization.dart';

enum AlertType { okAlert, yesNoAlert }

class Alert extends StatelessWidget {
  final String description;
  final AlertType type;

  const Alert({
    Key key,
    @required this.description,
    @required this.type,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: Text(_getTitle(context, type)),
        content: Text(
          description,
          overflow: TextOverflow.clip,
        ),
        actions: _getButtons(context, type));
  }

  String _getTitle(BuildContext context, AlertType type) {
    switch (type) {
      case AlertType.okAlert:
        return Strings.of(context).valueOf('label_alert_attention');
      case AlertType.yesNoAlert:
        return Strings.of(context).valueOf('label_alert_choose');
      default:
        return AppStrings.emptyString;
    }
  }

  List<Widget> _getButtons(BuildContext context, AlertType type) {
    switch (type) {
      case AlertType.okAlert:
        return <Widget>[
          FlatButton(
            child: Text(Strings.of(context).valueOf('label_alert_ok')),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ];
      case AlertType.yesNoAlert:
        return <Widget>[
          FlatButton(
            child: Text(Strings.of(context).valueOf('label_alert_yes')),
            onPressed: () {
              Navigator.pop(context, true);
            },
          ),
          FlatButton(
            child: Text(Strings.of(context).valueOf('label_alert_no')),
            onPressed: () {
              Navigator.pop(context, false);
            },
          ),
        ];
      default:
        return [];
    }
  }
}
