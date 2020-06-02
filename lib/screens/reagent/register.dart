import 'package:farma_reagente/components/alert.dart';
import 'package:farma_reagente/components/custom_checkbox_list.dart';
import 'package:farma_reagente/components/custom_dropdown.dart';
import 'package:farma_reagente/components/custom_input.dart';
import 'package:farma_reagente/constants/app_strings.dart';
import 'package:farma_reagente/database/app_database.dart';
import 'package:farma_reagente/models/incompatible_reagent.dart';
import 'package:farma_reagente/models/reagent.dart';
import 'package:farma_reagente/models/unit.dart';
import 'package:farma_reagente/screens/common/register_base.dart';
import 'package:flutter/material.dart';
import 'package:farma_reagente/extensions/string_extension.dart';
import 'package:internationalization/internationalization.dart';

class ReagentRegister extends StatefulWidget {
  final AppDatabase database;

  const ReagentRegister({Key key, this.database}) : super(key: key);

  @override
  _ReagentRegisterState createState() => _ReagentRegisterState();
}

class _ReagentRegisterState extends State<ReagentRegister> {
  final TextEditingController _controllerFieldDescription = TextEditingController();
  Map<int, bool> _checkboxList = Map();
  int _sequential;
  int _unitId;
  bool _firstBuild = true;

  @override
  Widget build(BuildContext context) {
    Future<List<CustomCheckboxType>> _values = _getValues(widget.database);

    if (_firstBuild) {
      _firstBuild = false;
      final Reagent args = ModalRoute.of(context).settings.arguments;

      if (args != null) {
        _sequential = args.id;
        _controllerFieldDescription.text = args.description;
        _unitId = args.unitId;

        widget.database.incompatibleReagentDAO.findElementsById(_sequential).then((value) {
          value.forEach((element) {
            _checkboxList[element.id] = true;
          });
        });
      }
    }

    return RegisterBase(
      name: Strings.of(context).valueOf('name_reagent_register'),
      context: context,
      save: () => _save(context, widget.database, _values),
      delete: () => _delete(context, widget.database),
      back: _back,
      children: <Widget>[
        CustomInput(
          label: Strings.of(context).valueOf('label_reagent_register_description'),
          controller: _controllerFieldDescription,
          maxLenght: 50,
          validator: (value) => _descriptionValidator(value, context),
        ),
        CustomDropdown(
          label: Strings.of(context).valueOf('label_reagent_register_unit'),
          value: _unitId,
          items: _unitList(widget.database),
          onChanged: (value) {
            setState(() => _unitId = value);
          },
        ),
        CustomCheckBoxList(
          label: Strings.of(context).valueOf('label_reagent_register_incompatible_reagent'),
          values: _values,
          checkedValues: _checkboxList,
        ),
      ],
    );
  }

  Future<List<DropdownMenuItem<int>>> _unitList(AppDatabase database) async {
    return (await database.unitDAO.findAll()).map(
      (Unit value) {
        return DropdownMenuItem<int>(
          value: value.id,
          child: Text(value.description.capitalize()),
        );
      },
    ).toList();
  }

  void _save(BuildContext context, AppDatabase database, Future<List<CustomCheckboxType>> values) async {
    if ((_unitId ?? -1) > 0) {
      final String _description = _controllerFieldDescription.text;

      if (_description != null && _unitId != null) {
        Reagent _reagent = Reagent(
          _sequential,
          _description,
          _unitId,
        );

        if (_sequential == null) {
          int id = await database.reagentDAO.insertReagent(_reagent);
          _saveIncompatible(database, id);
          _back();
        } else {
          await database.reagentDAO.updateReagent(_reagent);
          await database.incompatibleReagentDAO.deleteById(_reagent.id);
          _saveIncompatible(database, _reagent.id);
          _back();
        }
      }
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return Alert(
            description: Strings.of(context).valueOf('message_no_unit_selected'),
            type: AlertType.okAlert,
          );
        },
      );
    }
  }

  _saveIncompatible(AppDatabase database, int id) {
    _checkboxList.forEach((index, checked) async {
      if (checked) {
        await database.incompatibleReagentDAO.insertIncompatibleReagent(IncompatibleReagent(id, index));
      }
    });
  }

  Future<List<CustomCheckboxType>> _getValues(AppDatabase database) async {
    return (await database.reagentDAO.findAll())
        .map((Reagent reagent) => CustomCheckboxType(reagent.description, reagent))
        .toList();
  }

  _delete(BuildContext context, AppDatabase database) async {
    final String _description = _controllerFieldDescription.text;

    if (_description != null && _unitId != null) {
      Reagent _reagent = Reagent(
        _sequential,
        _description,
        _unitId,
      );

      if (_sequential != null) {
        if ((await database.reagentDAO.incompatibleReagentIsUsed(_sequential)).isEmpty) {
          if ((await database.reagentDAO.isUsed(_sequential)).isEmpty) {
            database.reagentDAO.deleteReagent(_reagent).then((id) => _back());

            _sequential = 0;
            _controllerFieldDescription.text = '';
            _unitId = 0;
          } else {
            showDialog(
              context: context,
              builder: (context) {
                return Alert(
                  description: Strings.of(context).valueOf('message_reagent_linked_formula'),
                  type: AlertType.okAlert,
                );
              },
            );
          }
        } else {
          showDialog(
            context: context,
            builder: (context) {
              return Alert(
                description: Strings.of(context).valueOf('message_reagent_linked'),
                type: AlertType.okAlert,
              );
            },
          );
        }
      }
    }
  }

  _back() {
    Navigator.pushReplacementNamed(context, AppStrings.routeReagentList);
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
