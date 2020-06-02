import 'package:farma_reagente/constants/database_strings.dart';
import 'package:farma_reagente/dao/dao.dart';
import 'package:farma_reagente/models/formula_reagent.dart';
import 'package:farma_reagente/models/reagent.dart';
import 'package:floor/floor.dart';

@dao
abstract class FormulaReagentDAO extends DAO {
  @Query('SELECT * FROM ${DatabaseStrings.sqlFormulaReagent_TableName}')
  Future<List<FormulaReagent>> findAll();

  @Query('SELECT * FROM ${DatabaseStrings.sqlFormulaReagent_TableName}')
  Stream<List<FormulaReagent>> findAllStream();

  @Query('''
          SELECT r.* 
            FROM ${DatabaseStrings.sqlFormulaReagent_TableName} fr
           INNER JOIN ${DatabaseStrings.sqlReagent_TableName} r on r.${DatabaseStrings.sqlReagent_ID} = fr.${DatabaseStrings.sqlFormulaReagent_ReagentID}
           WHERE fr.${DatabaseStrings.sqlFormulaReagent_FormulaID} = :formulaId
         ''')
  Future<List<Reagent>> findElementsById(int formulaId);

  @Query('''
          DELETE 
            FROM ${DatabaseStrings.sqlFormulaReagent_TableName} 
           WHERE ${DatabaseStrings.sqlFormulaReagent_FormulaID} = :formulaId
         ''')
  Future<FormulaReagent> deleteById(int formulaId);

  @insert
  Future<int> insertFormulaReagent(FormulaReagent formulaReagent);

  @insert
  Future<List<int>> insertList(List<FormulaReagent> formulaReagentList);

  @update
  Future<int> updateFormulaReagent(FormulaReagent formulaReagent);

  @update
  Future<int> updateList(List<FormulaReagent> formulaReagentList);

  @delete
  Future<int> deleteFormulaReagent(FormulaReagent formulaReagent);

  @delete
  Future<int> deleteList(List<FormulaReagent> formulaReagentList);
}
