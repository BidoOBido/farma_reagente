class DatabaseStrings {
  DatabaseStrings._();

  static const String sqlFormula_TableName = 'tb_formula';
  static const String sqlFormula_ID = 'id_formula';
  static const String sqlFormula_Name = 'name';
  static const String sqlFormula_Description = 'description';
  static const String sqlFormula_PreparationMode = 'preparation_mode';

  static const String sqlUnit_TableName = 'tb_unit';
  static const String sqlUnit_ID = 'id_unit';
  static const String sqlUnit_Description = 'description';
  static const String sqlUnit_TypeID = 'id_type';
  static const String sqlUnit_Precision = 'precision';

  static const String sqlReagent_TableName = 'tb_reagent';
  static const String sqlReagent_ID = 'id_reagent';
  static const String sqlReagent_Description = 'description';
  static const String sqlReagent_UnitID = 'id_unit';

  static const String sqlFormulaReagent_TableName = 'tb_formula_reagent';
  static const String sqlFormulaReagent_FormulaID = 'id_formula';
  static const String sqlFormulaReagent_ReagentID = 'id_reagent';

  static const String sqlIncompatibleReagent_TableName = 'tb_incompatible_reagent';
  static const String sqlIncompatibleReagent_ReagentID = 'id_reagent';
  static const String sqlIncompatibleReagent_IncompatibleReagentID = 'id_incompatible_reagent';
}
