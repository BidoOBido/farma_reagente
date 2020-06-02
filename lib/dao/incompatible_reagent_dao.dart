import 'package:farma_reagente/constants/database_strings.dart';
import 'package:farma_reagente/dao/dao.dart';
import 'package:farma_reagente/models/incompatible_reagent.dart';
import 'package:farma_reagente/models/reagent.dart';
import 'package:floor/floor.dart';

@dao
abstract class IncompatibleReagentDAO extends DAO {
  @Query('SELECT * FROM ${DatabaseStrings.sqlIncompatibleReagent_TableName}')
  Future<List<IncompatibleReagent>> findAll();

  @Query('SELECT * FROM ${DatabaseStrings.sqlIncompatibleReagent_TableName}')
  Stream<List<IncompatibleReagent>> findAllStream();

  @Query('''
          SELECT r.* 
            FROM ${DatabaseStrings.sqlIncompatibleReagent_TableName} ir
           INNER JOIN ${DatabaseStrings.sqlReagent_TableName} r on r.${DatabaseStrings.sqlReagent_ID} = ir.${DatabaseStrings.sqlIncompatibleReagent_IncompatibleReagentID} 
          WHERE ir.${DatabaseStrings.sqlIncompatibleReagent_ReagentID} = :reagentID
         ''')
  Future<List<Reagent>> findElementsById(int reagentID);

  @Query('''
          DELETE
            FROM ${DatabaseStrings.sqlIncompatibleReagent_TableName} 
          WHERE ${DatabaseStrings.sqlIncompatibleReagent_ReagentID} = :reagentID
         ''')
  Future<IncompatibleReagent> deleteById(int reagentID);

  @insert
  Future<int> insertIncompatibleReagent(IncompatibleReagent incompatibleReagent);

  @insert
  Future<List<int>> insertList(List<IncompatibleReagent> incompatibleReagentList);

  @update
  Future<int> updateIncompatibleReagent(IncompatibleReagent incompatibleReagent);

  @update
  Future<int> updateList(List<IncompatibleReagent> incompatibleReagentList);

  @delete
  Future<int> deleteIncompatibleReagent(IncompatibleReagent incompatibleReagent);

  @delete
  Future<int> deleteList(List<IncompatibleReagent> incompatibleReagentList);
}
