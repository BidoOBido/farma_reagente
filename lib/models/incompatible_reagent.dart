import 'package:farma_reagente/constants/database_strings.dart';
import 'package:farma_reagente/models/reagent.dart';
import 'package:floor/floor.dart';

@Entity(
  tableName: DatabaseStrings.sqlIncompatibleReagent_TableName,
  primaryKeys: [
    DatabaseStrings.sqlIncompatibleReagent_ReagentID,
    DatabaseStrings.sqlIncompatibleReagent_IncompatibleReagentID,
  ],
  foreignKeys: [
    ForeignKey(
      childColumns: [DatabaseStrings.sqlIncompatibleReagent_ReagentID],
      parentColumns: [DatabaseStrings.sqlReagent_ID],
      entity: Reagent,
      onDelete: ForeignKeyAction.CASCADE,
      onUpdate: ForeignKeyAction.CASCADE,
    ),
    ForeignKey(
      childColumns: [DatabaseStrings.sqlIncompatibleReagent_IncompatibleReagentID],
      parentColumns: [DatabaseStrings.sqlReagent_ID],
      entity: Reagent,
      onDelete: ForeignKeyAction.CASCADE,
      onUpdate: ForeignKeyAction.CASCADE,
    )
  ],
)
class IncompatibleReagent {
  @ColumnInfo(name: DatabaseStrings.sqlIncompatibleReagent_ReagentID)
  final int reagentID;

  @ColumnInfo(name: DatabaseStrings.sqlIncompatibleReagent_IncompatibleReagentID)
  final int incompatibleReagentID;

  IncompatibleReagent(
    this.reagentID,
    this.incompatibleReagentID,
  );
}
