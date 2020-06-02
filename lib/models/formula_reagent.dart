import 'package:farma_reagente/constants/database_strings.dart';
import 'package:farma_reagente/models/formula.dart';
import 'package:farma_reagente/models/reagent.dart';
import 'package:floor/floor.dart';

@Entity(
  tableName: DatabaseStrings.sqlFormulaReagent_TableName,
  primaryKeys: [
    DatabaseStrings.sqlFormulaReagent_FormulaID,
    DatabaseStrings.sqlFormulaReagent_ReagentID,
  ],
  foreignKeys: [
    ForeignKey(
      childColumns: [DatabaseStrings.sqlFormulaReagent_FormulaID],
      parentColumns: [DatabaseStrings.sqlFormula_ID],
      entity: Formula,
      onDelete: ForeignKeyAction.CASCADE,
      onUpdate: ForeignKeyAction.CASCADE,
    ),
    ForeignKey(
      childColumns: [DatabaseStrings.sqlFormulaReagent_ReagentID],
      parentColumns: [DatabaseStrings.sqlReagent_ID],
      entity: Reagent,
      onDelete: ForeignKeyAction.CASCADE,
      onUpdate: ForeignKeyAction.CASCADE,
    )
  ],
)
class FormulaReagent {
  @ColumnInfo(name: DatabaseStrings.sqlFormulaReagent_FormulaID)
  final int formulaID;

  @ColumnInfo(name: DatabaseStrings.sqlFormulaReagent_ReagentID)
  final int reagentID;

  FormulaReagent(
    this.formulaID,
    this.reagentID,
  );
}
