import 'package:farma_reagente/constants/app_strings.dart';
import 'package:farma_reagente/constants/database_strings.dart';
import 'package:farma_reagente/models/unit.dart';
import 'package:floor/floor.dart';

@Entity(
  tableName: DatabaseStrings.sqlReagent_TableName,
  foreignKeys: [
    ForeignKey(
      childColumns: [DatabaseStrings.sqlReagent_UnitID],
      parentColumns: [DatabaseStrings.sqlUnit_ID],
      entity: Unit,
    )
  ],
)
class Reagent {
  @PrimaryKey(autoGenerate: true)
  @ColumnInfo(name: DatabaseStrings.sqlReagent_ID)
  final int id;

  @ColumnInfo(name: DatabaseStrings.sqlReagent_Description)
  final String description;

  @ColumnInfo(name: DatabaseStrings.sqlReagent_UnitID)
  final int unitId;

  Reagent(
    this.id,
    this.description,
    this.unitId,
  );

  Reagent.id(id)
      : id = id,
        description = AppStrings.emptyString,
        unitId = 0;
}
