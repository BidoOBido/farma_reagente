import 'package:emojis/emojis.dart';
import 'package:farma_reagente/constants/styles.dart';
import 'package:flutter/material.dart';
import 'package:internationalization/internationalization.dart';

class UnknownError extends StatelessWidget {
  const UnknownError({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            Emojis.warning,
            style: Styles.errorText,
          ),
          Text(
            Strings.of(context).valueOf('message_unknown_error'),
            style: Styles.errorText,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
