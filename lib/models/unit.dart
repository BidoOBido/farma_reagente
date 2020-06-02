import 'package:farma_reagente/constants/app_strings.dart';
import 'package:farma_reagente/constants/database_strings.dart';
import 'package:floor/floor.dart';

enum UnitType { liquid, solid }

class EnumUnitType {
  static String getName(UnitType type) {
    switch (type) {
      case UnitType.liquid:
        return 'líquido';
      case UnitType.solid:
        return 'sólido';
      default:
        return '';
    }
  }
}

@Entity(tableName: DatabaseStrings.sqlUnit_TableName)
class Unit {
  @PrimaryKey(autoGenerate: true)
  @ColumnInfo(name: DatabaseStrings.sqlUnit_ID)
  final int id;

  @ColumnInfo(name: DatabaseStrings.sqlUnit_Description)
  final String description;

  @ColumnInfo(name: DatabaseStrings.sqlUnit_TypeID)
  final int unitTypeID;

  @ColumnInfo(name: DatabaseStrings.sqlUnit_Precision)
  final int precision;

  Unit(
    this.id,
    this.description,
    this.unitTypeID,
    this.precision,
  );

  Unit.id(id)
      : id = id,
        description = AppStrings.emptyString,
        unitTypeID = 0,
        precision = 0;
}
