import 'package:farma_reagente/constants/database_strings.dart';
import 'package:farma_reagente/dao/dao.dart';
import 'package:farma_reagente/models/formula.dart';
import 'package:floor/floor.dart';

@dao
abstract class FormulaDAO extends DAO {
  @Query('SELECT * FROM ${DatabaseStrings.sqlFormula_TableName}')
  Future<List<Formula>> findAll();

  @Query('SELECT * FROM ${DatabaseStrings.sqlFormula_TableName}')
  Stream<List<Formula>> findAllStream();

  @Query('SELECT * FROM ${DatabaseStrings.sqlFormula_TableName} WHERE ${DatabaseStrings.sqlFormula_ID} = :id')
  Future<Formula> findElementsById(int id);

  @Query('DELETE FROM ${DatabaseStrings.sqlFormula_TableName} WHERE ${DatabaseStrings.sqlFormula_ID} = :id')
  Future<void> deleteById(int id);

  @insert
  Future<int> insertFormula(Formula formula);

  @insert
  Future<List<int>> insertList(List<Formula> formulaList);

  @update
  Future<int> updateFormula(Formula formula);

  @update
  Future<int> updateList(List<Formula> formulaList);

  @delete
  Future<int> deleteFormula(Formula formula);

  @delete
  Future<int> deleteList(List<Formula> formulaList);
}
