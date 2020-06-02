import 'package:farma_reagente/constants/app_strings.dart';

extension StringExtension on String {
  String capitalize() {
    if (this.isEmpty) {
      return AppStrings.emptyString;
    } else {
      return "${this[0].toUpperCase()}${this.substring(1)}";
    }
  }
}
