import 'package:farma_reagente/components/alert.dart';
import 'package:farma_reagente/components/custom_checkbox_list.dart';
import 'package:farma_reagente/components/custom_input.dart';
import 'package:farma_reagente/constants/app_strings.dart';
import 'package:farma_reagente/database/app_database.dart';
import 'package:farma_reagente/models/formula.dart';
import 'package:farma_reagente/models/formula_reagent.dart';
import 'package:farma_reagente/models/reagent.dart';
import 'package:farma_reagente/screens/common/register_base.dart';
import 'package:flutter/material.dart';
import 'package:internationalization/internationalization.dart';
import 'package:sqflite/sqlite_api.dart';

class FormulaRegister extends StatefulWidget {
  final AppDatabase database;

  const FormulaRegister({Key key, this.database}) : super(key: key);
  @override
  _FormulaRegisterState createState() => _FormulaRegisterState();
}

class _FormulaRegisterState extends State<FormulaRegister> {
  final TextEditingController _controllerFieldName = TextEditingController();
  final TextEditingController _controllerFieldDescription = TextEditingController();
  int _sequential;
  Map<int, bool> _checkboxList = Map();
  final TextEditingController _controllerFieldPreparationMode = TextEditingController();
  bool _firstBuild = true;

  @override
  Widget build(BuildContext context) {
    Future<List<CustomCheckboxType>> _values = _getValues(widget.database);

    if (_firstBuild) {
      _firstBuild = false;
      final Formula args = ModalRoute.of(context).settings.arguments;

      if (args != null) {
        _sequential = args.id;
        _controllerFieldName.text = args.name;
        _controllerFieldDescription.text = args.description;
        _controllerFieldPreparationMode.text = args.preparationMode;

        widget.database.formulaReagentDAO.findElementsById(_sequential).then((value) {
          value.forEach((element) {
            _checkboxList[element.id] = true;
          });
        });
      }
    }

    return RegisterBase(
      name: Strings.of(context).valueOf('name_formula_register'),
      context: context,
      save: () => _save(context, widget.database, _values),
      delete: () => _delete(context, widget.database),
      back: _back,
      children: <Widget>[
        CustomInput(
          label: Strings.of(context).valueOf('label_formula_register_name'),
          controller: _controllerFieldName,
          maxLenght: 50,
          validator: (value) => _nameValidator(value, context),
        ),
        CustomInput(
          label: Strings.of(context).valueOf('label_formula_register_description'),
          controller: _controllerFieldDescription,
          maxLenght: 100,
          validator: (value) => _descriptionValidator(value, context),
        ),
        CustomCheckBoxList(
          label: Strings.of(context).valueOf('label_formula_register_reagent_list'),
          values: _values,
          checkedValues: _checkboxList,
        ),
        CustomInput(
          label: Strings.of(context).valueOf('label_formula_register_preparation_mode'),
          controller: _controllerFieldPreparationMode,
          maxLenght: 500,
          validator: (value) => _preparationModeValidator(value, context),
          keyboardType: TextInputType.multiline,
        ),
      ],
    );
  }

  void _save(BuildContext context, AppDatabase database, Future<List<CustomCheckboxType>> values) async {
    if (_checkboxList.isNotEmpty) {
      final String _description = _controllerFieldName.text;
      final String _subDescription = _controllerFieldDescription.text;
      final String _preparationMode = _controllerFieldPreparationMode.text;

      if (_description != null && _subDescription != null && _preparationMode != null) {
        Formula _formula = Formula(
          _sequential,
          _description,
          _subDescription,
          _preparationMode,
        );

        if (_sequential == null) {
          int id = await database.formulaDAO.insertFormula(_formula);
          _saveReagent(database, id);
          _back();
        } else {
          await database.formulaDAO.updateFormula(_formula);
          await database.formulaReagentDAO.deleteById(_formula.id);
          _saveReagent(database, _formula.id);
          _back();
        }
      }
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return Alert(
            description: Strings.of(context).valueOf('message_no_reagent_selected'),
            type: AlertType.okAlert,
          );
        },
      );
    }
  }

  _saveReagent(AppDatabase database, int id) {
    _checkboxList.forEach((index, checked) async {
      if (checked) {
        await database.formulaReagentDAO.insertFormulaReagent(FormulaReagent(id, index));
      }
    });
  }

  Future<List<CustomCheckboxType>> _getValues(AppDatabase database) async {
    return (await database.reagentDAO.findAll())
        .map((Reagent reagent) => CustomCheckboxType(reagent.description, reagent))
        .toList();
  }

  _delete(BuildContext context, AppDatabase database) {
    final String _description = _controllerFieldName.text;
    final String _subDescription = _controllerFieldDescription.text;
    final String _preparationMode = _controllerFieldPreparationMode.text;

    if (_description != null && _subDescription != null && _preparationMode != null) {
      Formula _formula = Formula(
        _sequential,
        _description,
        _subDescription,
        _preparationMode,
      );

      if (_sequential != null) {
        database.formulaDAO.deleteFormula(_formula).then((id) => _back());
      }
    }

    _sequential = 0;
    _controllerFieldName.text = '';
    _controllerFieldPreparationMode.text = '';
    _controllerFieldPreparationMode.text = '';
  }

  _back() {
    Navigator.pushReplacementNamed(context, AppStrings.routeFormulaList);
  }

  final Function(String, BuildContext) _nameValidator = (String name, BuildContext context) {
    if (name.isEmpty) {
      return Strings.of(context).valueOf('message_empty_name');
    } else if (name.length < 3) {
      return Strings.of(context).valueOf('message_invalid_name');
    }
    return null;
  };

  final Function(String, BuildContext) _descriptionValidator = (String description, BuildContext context) {
    if (description.isEmpty) {
      return Strings.of(context).valueOf('message_empty_description');
    } else if (description.length < 3) {
      return Strings.of(context).valueOf('message_invalid_description');
    }
    return null;
  };

  final Function(String, BuildContext) _preparationModeValidator = (String preparationMode, BuildContext context) {
    if (preparationMode.isEmpty) {
      return Strings.of(context).valueOf('message_empty_preparationMode');
    } else if (preparationMode.length < 3) {
      return Strings.of(context).valueOf('message_invalid_preparationMode');
    }
    return null;
  };
}
