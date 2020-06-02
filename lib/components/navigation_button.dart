import 'package:farma_reagente/constants/app_strings.dart';
import 'package:farma_reagente/constants/styles.dart';
import 'package:flutter/material.dart';

class NavigationButtonNext extends StatelessWidget {
  final VoidCallback onPressed;
  final String label;

  const NavigationButtonNext({
    Key key,
    @required this.onPressed,
    this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      padding: Styles.paddingOnlyRight,
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Text(
            label == null ? AppStrings.emptyString : label,
            style: Styles.whiteText,
          ),
          Icon(
            Icons.arrow_forward,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}

class NavigationButtonPrevious extends StatelessWidget {
  final VoidCallback onPressed;
  final String label;

  const NavigationButtonPrevious({
    Key key,
    @required this.onPressed,
    this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      padding: Styles.paddingOnlyLeft,
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          Text(
            label == null ? AppStrings.emptyString : label,
            style: Styles.whiteText,
          ),
        ],
      ),
    );
  }
}
