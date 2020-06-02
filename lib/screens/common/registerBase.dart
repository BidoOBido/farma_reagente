import 'package:farma_reagente/components/custom_button.dart';
import 'package:flutter/material.dart';

class RegisterBase extends StatelessWidget {
  final String name;
  final List<Widget> children;
  final BuildContext context;
  final VoidCallback save;
  final VoidCallback delete;

  const RegisterBase({
    Key key,
    @required this.name,
    @required this.context,
    @required this.children,
    @required this.save,
    @required this.delete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
      ),
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Column(
              children: children,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CustomButton(
                  onPressed: () => save(),
                  buttonType: CustomButtonType.save,
                ),
                CustomButton(
                  onPressed: () => delete(),
                  buttonType: CustomButtonType.delete,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
