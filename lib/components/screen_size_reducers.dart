import 'package:flutter/material.dart';

Size screenSize(BuildContext context) {
  return MediaQuery.of(context).size;
}

double percentageScreenHeight(BuildContext context, {double percentage = 1, double reducedBy = 0.0}) {
  return (screenSize(context).height - reducedBy) * percentage;
}

double percentageScreenWidth(BuildContext context, {double percentage = 1, double reducedBy = 0.0}) {
  return (screenSize(context).width - reducedBy) * percentage;
}

double screenHeight(BuildContext context, {double dividedBy = 1, double reducedBy = 0.0}) {
  return percentageScreenHeight(context, percentage: (1 / dividedBy), reducedBy: reducedBy);
}

double screenWidth(BuildContext context, {double dividedBy = 1, double reducedBy = 0.0}) {
  return percentageScreenWidth(context, percentage: (1 / dividedBy), reducedBy: reducedBy);
}

double screenHeightExcludingToolbar(BuildContext context, {double dividedBy = 1}) {
  return screenHeight(context, dividedBy: dividedBy, reducedBy: kToolbarHeight);
}
