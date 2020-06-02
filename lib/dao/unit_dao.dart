import 'package:farma_reagente/constants/database_strings.dart';
import 'package:farma_reagente/dao/dao.dart';
import 'package:farma_reagente/models/unit.dart';
import 'package:floor/floor.dart';

@dao
abstract class UnitDAO extends DAO {
  @Query('SELECT * FROM ${DatabaseStrings.sqlUnit_TableName}')
  Future<List<Unit>> findAll();

  @Query('SELECT * FROM ${DatabaseStrings.sqlUnit_TableName}')
  Stream<List<Unit>> findAllStream();

  @Query('SELECT * FROM ${DatabaseStrings.sqlUnit_TableName} WHERE ${DatabaseStrings.sqlUnit_ID} = :id')
  Future<Unit> findElementsById(int id);

  @Query('DELETE FROM ${DatabaseStrings.sqlUnit_TableName} WHERE ${DatabaseStrings.sqlUnit_ID} = :id')
  Future<Unit> deleteById(int id);

  @Query('SELECT * FROM ${DatabaseStrings.sqlReagent_TableName} WHERE ${DatabaseStrings.sqlReagent_UnitID} = :id')
  Future<List<Unit>> isUsed(int id);

  @insert
  Future<int> insertUnit(Unit unit);

  @insert
  Future<List<int>> insertList(List<Unit> unitList);

  @update
  Future<int> updateUnit(Unit unit);

  @update
  Future<int> updateList(List<Unit> unitList);

  @delete
  Future<int> deleteUnit(Unit unit);

  @delete
  Future<int> deleteList(List<Unit> unitList);
}
