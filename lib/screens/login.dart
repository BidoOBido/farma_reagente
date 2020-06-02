import 'package:farma_reagente/components/custom_button.dart';
import 'package:farma_reagente/components/custom_input.dart';
import 'package:farma_reagente/components/screen_size_reducers.dart';
import 'package:farma_reagente/constants/app_strings.dart';
import 'package:farma_reagente/constants/styles.dart';
import 'package:flutter/material.dart';
import 'package:internationalization/internationalization.dart';

class Login extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _controllerFieldUser = TextEditingController();
  final TextEditingController _controllerFieldPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        appBar: AppBar(
          title: Text(AppStrings.appName),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                padding: Styles.paddingAll,
                child: Image(
                  width: screenSize(context).width,
                  image: AssetImage('assets/images/logo.png'),
                ),
              ),
              Card(
                elevation: 3.0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    CustomInput(
                      label: Strings.of(context).valueOf('label_login_user'),
                      controller: _controllerFieldUser,
                      maxLenght: 64,
                      keyboardType: TextInputType.text,
                      validator: (value) => _userValidator(value, context),
                    ),
                    CustomInput(
                      label: Strings.of(context).valueOf('label_login_password'),
                      controller: _controllerFieldPassword,
                      maxLenght: 64,
                      icon: Icon(Icons.vpn_key),
                      validator: (value) => _passwordValidator(value, context),
                    ),
                    CustomButton(
                      onPressed: () => _logIn(context),
                      buttonType: CustomButtonType.login,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _logIn(BuildContext _context) {
    if (_formKey.currentState.validate()) {
      Navigator.pushReplacementNamed(
        _context,
        AppStrings.routeUnitList,
      );
    }
  }

  final Function(String, BuildContext) _userValidator = (String username, BuildContext context) {
    if (username.isEmpty) {
      return Strings.of(context).valueOf('message_empty_user');
    } else if (username.length < 3) {
      return Strings.of(context).valueOf('message_invalid_user');
    }
    return null;
  };

  final Function(String, BuildContext) _passwordValidator = (String password, BuildContext context) {
    if (password.isEmpty) {
      return Strings.of(context).valueOf('message_empty_password');
    } else if (password.length < 3) {
      return Strings.of(context).valueOf('message_invalid_password');
    }
    return null;
  };
}
