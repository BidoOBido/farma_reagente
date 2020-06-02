import 'package:farma_reagente/constants/app_strings.dart';
import 'package:farma_reagente/constants/database_strings.dart';
import 'package:floor/floor.dart';

@Entity(tableName: DatabaseStrings.sqlFormula_TableName)
class Formula {
  @PrimaryKey(autoGenerate: true)
  @ColumnInfo(name: DatabaseStrings.sqlFormula_ID)
  final int id;

  @ColumnInfo(name: DatabaseStrings.sqlFormula_Name)
  final String name;

  @ColumnInfo(name: DatabaseStrings.sqlFormula_Description)
  final String description;

  @ColumnInfo(name: DatabaseStrings.sqlFormula_PreparationMode)
  final String preparationMode;

  Formula(
    this.id,
    this.name,
    this.description,
    this.preparationMode,
  );

  Formula.id(id)
      : id = id,
        name = AppStrings.emptyString,
        description = AppStrings.emptyString,
        preparationMode = AppStrings.emptyString;
}
