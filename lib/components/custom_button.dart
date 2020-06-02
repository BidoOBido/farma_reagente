import 'package:farma_reagente/constants/styles.dart';
import 'package:farma_reagente/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:internationalization/internationalization.dart';

enum CustomButtonType { save, delete, login }

class CustomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final CustomButtonType buttonType;

  const CustomButton({
    Key key,
    @required this.onPressed,
    @required this.buttonType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: Styles.paddingAll,
      child: RaisedButton(
        child: Text(_getButtonText(buttonType, context)),
        color: _getButtonColor(buttonType),
        onPressed: onPressed,
      ),
    );
  }

  Color _getButtonColor(CustomButtonType buttonTipe) {
    if (buttonTipe == CustomButtonType.save) {
      return CustomColors.colorButtonSave;
    } else if (buttonTipe == CustomButtonType.delete) {
      return CustomColors.colorButtonDelete;
    } else if (buttonTipe == CustomButtonType.login) {
      return CustomColors.colorButtonLogin;
    }
    return null;
  }

  String _getButtonText(CustomButtonType buttonTipe, BuildContext context) {
    if (buttonTipe == CustomButtonType.save) {
      return Strings.of(context).valueOf("label_button_save");
    } else if (buttonTipe == CustomButtonType.delete) {
      return Strings.of(context).valueOf("label_button_delete");
    } else if (buttonTipe == CustomButtonType.login) {
      return Strings.of(context).valueOf("label_button_login");
    }
    return null;
  }
}
