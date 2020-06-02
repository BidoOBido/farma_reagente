import 'package:farma_reagente/constants/database_strings.dart';
import 'package:farma_reagente/dao/dao.dart';
import 'package:farma_reagente/models/reagent.dart';
import 'package:floor/floor.dart';

@dao
abstract class ReagentDAO extends DAO {
  @Query('SELECT * FROM ${DatabaseStrings.sqlReagent_TableName}')
  Future<List<Reagent>> findAll();

  @Query('SELECT * FROM ${DatabaseStrings.sqlReagent_TableName}')
  Stream<List<Reagent>> findAllStream();

  @Query('SELECT * FROM ${DatabaseStrings.sqlReagent_TableName} WHERE ${DatabaseStrings.sqlReagent_ID} = :id')
  Future<Reagent> findElementsById(int id);

  @Query('DELETE FROM ${DatabaseStrings.sqlReagent_TableName} WHERE ${DatabaseStrings.sqlReagent_ID} = :id')
  Future<Reagent> deleteById(int id);

  @Query('''
          SELECT * 
            FROM ${DatabaseStrings.sqlIncompatibleReagent_TableName} 
           WHERE ${DatabaseStrings.sqlIncompatibleReagent_IncompatibleReagentID} = :id
         ''')
  Future<List<Reagent>> incompatibleReagentIsUsed(int id);

  @Query('''
          SELECT * 
            FROM ${DatabaseStrings.sqlFormulaReagent_TableName} 
           WHERE ${DatabaseStrings.sqlFormulaReagent_ReagentID} = :id
         ''')
  Future<List<Reagent>> isUsed(int id);

  @insert
  Future<int> insertReagent(Reagent reagent);

  @insert
  Future<List<int>> insertList(List<Reagent> reagentList);

  @update
  Future<int> updateReagent(Reagent reagent);

  @update
  Future<int> updateList(List<Reagent> reagentList);

  @delete
  Future<int> deleteReagent(Reagent reagent);

  @delete
  Future<int> deleteList(List<Reagent> reagentList);
}
