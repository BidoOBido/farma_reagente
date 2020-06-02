import 'package:farma_reagente/components/alert.dart';
import 'package:farma_reagente/components/custom_slider.dart';
import 'package:farma_reagente/components/custom_dropdown.dart';
import 'package:farma_reagente/components/custom_input.dart';
import 'package:farma_reagente/constants/app_strings.dart';
import 'package:farma_reagente/database/app_database.dart';
import 'package:farma_reagente/models/unit.dart';
import 'package:farma_reagente/screens/common/register_base.dart';
import 'package:flutter/material.dart';
import 'package:farma_reagente/extensions/string_extension.dart';
import 'package:internationalization/internationalization.dart';
import 'package:sqflite/sqflite.dart';

class UnitRegister extends StatefulWidget {
  final AppDatabase database;

  const UnitRegister({
    Key key,
    @required this.database,
  }) : super(key: key);

  @override
  _UnitRegisterState createState() => _UnitRegisterState();
}

class _UnitRegisterState extends State<UnitRegister> {
  final TextEditingController _controllerFieldDescription = TextEditingController();
  int _sequential;
  int _type = 0;
  int _precision = 0;
  bool _firstBuild = true;

  @override
  Widget build(BuildContext context) {
    if (_firstBuild) {
      _firstBuild = false;
      Unit args = ModalRoute.of(context).settings.arguments;

      if (args != null) {
        _sequential = args.id;
        _controllerFieldDescription.text = args.description;
        _type = args.unitTypeID;
        _precision = args.precision;
      }
    }

    return RegisterBase(
      name: Strings.of(context).valueOf('name_unit_register'),
      context: context,
      save: () => _save(context, widget.database),
      delete: () => _delete(context, widget.database),
      back: _back,
      children: <Widget>[
        CustomInput(
          label: Strings.of(context).valueOf('label_unit_register_description'),
          controller: _controllerFieldDescription,
          maxLenght: 50,
          validator: (value) => _descriptionValidator(value, context),
        ),
        CustomDropdown(
          label: Strings.of(context).valueOf('label_unit_register_type'),
          value: _type,
          items: _unitTypeList(),
          onChanged: (value) {
            setState(() => _type = value);
          },
        ),
        CustomSlider(
          label: Strings.of(context).valueOf('label_unit_register_precision'),
          value: _precision,
          min: 0.0,
          max: 5.0,
          onChanged: (double newValue) {
            setState(() {
              _precision = newValue.round();
            });
          },
        ),
      ],
    );
  }

  Future<List<DropdownMenuItem<int>>> _unitTypeList() async {
    return UnitType.values.map(
      (UnitType value) {
        return DropdownMenuItem<int>(
          value: value.index,
          child: Text(EnumUnitType.getName(value).capitalize()),
        );
      },
    ).toList();
  }

  void _save(BuildContext context, AppDatabase database) async {
    final String _description = _controllerFieldDescription.text;

    if (_description != null && _type != null && _precision != null) {
      Unit _unit = Unit(
        _sequential,
        _description,
        UnitType.values[_type].index,
        _precision,
      );

      if (_sequential == null) {
        database.unitDAO.insertUnit(_unit).then((id) => _back());
      } else {
        database.unitDAO.updateUnit(_unit).then((id) => _back());
      }
    }
  }

  _delete(BuildContext context, AppDatabase database) async {
    final String _description = _controllerFieldDescription.text;

    if (_description != null && _type != null && _precision != null) {
      Unit _unit = Unit(
        _sequential,
        _description,
        UnitType.values[_type].index,
        _precision,
      );

      if (_sequential != null) {
        if ((await database.unitDAO.isUsed(_sequential)).isEmpty) {
          database.unitDAO.deleteUnit(_unit).then((id) => _back());
        } else {
          showDialog(
            context: context,
            builder: (context) {
              return Alert(
                description: Strings.of(context).valueOf('message_unit_linked'),
                type: AlertType.okAlert,
              );
            },
          );
        }
      }
    }
  }
  
  _back() {
    Navigator.pushReplacementNamed(context, AppStrings.routeUnitList);
  }

  final Function(String, BuildContext) _descriptionValidator = (String description, BuildContext context) {
    if (description.isEmpty) {
      return Strings.of(context).valueOf('message_empty_description');
    } else if (description.length < 3) {
      return Strings.of(context).valueOf('message_invalid_description');
    }
    return null;
  };
}
