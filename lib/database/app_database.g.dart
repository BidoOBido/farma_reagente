// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String name;

  final List<Migration> _migrations = [];

  Callback _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? join(await sqflite.getDatabasesPath(), name)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String> listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  UnitDAO _unitDAOInstance;

  ReagentDAO _reagentDAOInstance;

  FormulaDAO _formulaDAOInstance;

  FormulaReagentDAO _formulaReagentDAOInstance;

  IncompatibleReagentDAO _incompatibleReagentDAOInstance;

  Future<sqflite.Database> open(String path, List<Migration> migrations,
      [Callback callback]) async {
    return sqflite.openDatabase(
      path,
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `tb_unit` (`id_unit` INTEGER PRIMARY KEY AUTOINCREMENT, `description` TEXT, `id_type` INTEGER, `precision` INTEGER)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `tb_reagent` (`id_reagent` INTEGER PRIMARY KEY AUTOINCREMENT, `description` TEXT, `id_unit` INTEGER, FOREIGN KEY (`id_unit`) REFERENCES `tb_unit` (`id_unit`) ON UPDATE NO ACTION ON DELETE NO ACTION)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `tb_formula` (`id_formula` INTEGER PRIMARY KEY AUTOINCREMENT, `name` TEXT, `description` TEXT, `preparation_mode` TEXT)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `tb_formula_reagent` (`id_formula` INTEGER, `id_reagent` INTEGER, FOREIGN KEY (`id_formula`) REFERENCES `tb_formula` (`id_formula`) ON UPDATE CASCADE ON DELETE CASCADE, FOREIGN KEY (`id_reagent`) REFERENCES `tb_reagent` (`id_reagent`) ON UPDATE CASCADE ON DELETE CASCADE, PRIMARY KEY (`id_formula`, `id_reagent`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `tb_incompatible_reagent` (`id_reagent` INTEGER, `id_incompatible_reagent` INTEGER, FOREIGN KEY (`id_reagent`) REFERENCES `tb_reagent` (`id_reagent`) ON UPDATE CASCADE ON DELETE CASCADE, FOREIGN KEY (`id_incompatible_reagent`) REFERENCES `tb_reagent` (`id_reagent`) ON UPDATE CASCADE ON DELETE CASCADE, PRIMARY KEY (`id_reagent`, `id_incompatible_reagent`))');

        await callback?.onCreate?.call(database, version);
      },
    );
  }

  @override
  UnitDAO get unitDAO {
    return _unitDAOInstance ??= _$UnitDAO(database, changeListener);
  }

  @override
  ReagentDAO get reagentDAO {
    return _reagentDAOInstance ??= _$ReagentDAO(database, changeListener);
  }

  @override
  FormulaDAO get formulaDAO {
    return _formulaDAOInstance ??= _$FormulaDAO(database, changeListener);
  }

  @override
  FormulaReagentDAO get formulaReagentDAO {
    return _formulaReagentDAOInstance ??=
        _$FormulaReagentDAO(database, changeListener);
  }

  @override
  IncompatibleReagentDAO get incompatibleReagentDAO {
    return _incompatibleReagentDAOInstance ??=
        _$IncompatibleReagentDAO(database, changeListener);
  }
}

class _$UnitDAO extends UnitDAO {
  _$UnitDAO(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database, changeListener),
        _unitInsertionAdapter = InsertionAdapter(
            database,
            'tb_unit',
            (Unit item) => <String, dynamic>{
                  'id_unit': item.id,
                  'description': item.description,
                  'id_type': item.unitTypeID,
                  'precision': item.precision
                },
            changeListener),
        _unitUpdateAdapter = UpdateAdapter(
            database,
            'tb_unit',
            ['id_unit'],
            (Unit item) => <String, dynamic>{
                  'id_unit': item.id,
                  'description': item.description,
                  'id_type': item.unitTypeID,
                  'precision': item.precision
                },
            changeListener),
        _unitDeletionAdapter = DeletionAdapter(
            database,
            'tb_unit',
            ['id_unit'],
            (Unit item) => <String, dynamic>{
                  'id_unit': item.id,
                  'description': item.description,
                  'id_type': item.unitTypeID,
                  'precision': item.precision
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  static final _tb_unitMapper = (Map<String, dynamic> row) => Unit(
      row['id_unit'] as int,
      row['description'] as String,
      row['id_type'] as int,
      row['precision'] as int);

  final InsertionAdapter<Unit> _unitInsertionAdapter;

  final UpdateAdapter<Unit> _unitUpdateAdapter;

  final DeletionAdapter<Unit> _unitDeletionAdapter;

  @override
  Future<List<Unit>> findAll() async {
    return _queryAdapter.queryList('SELECT * FROM tb_unit',
        mapper: _tb_unitMapper);
  }

  @override
  Stream<List<Unit>> findAllStream() {
    return _queryAdapter.queryListStream('SELECT * FROM tb_unit',
        tableName: 'tb_unit', mapper: _tb_unitMapper);
  }

  @override
  Future<Unit> findElementsById(int id) async {
    return _queryAdapter.query('SELECT * FROM tb_unit WHERE id_unit = ?',
        arguments: <dynamic>[id], mapper: _tb_unitMapper);
  }

  @override
  Future<Unit> deleteById(int id) async {
    return _queryAdapter.query('DELETE FROM tb_unit WHERE id_unit = ?',
        arguments: <dynamic>[id], mapper: _tb_unitMapper);
  }

  @override
  Future<List<Unit>> isUsed(int id) async {
    return _queryAdapter.queryList('SELECT * FROM tb_reagent WHERE id_unit = ?',
        arguments: <dynamic>[id], mapper: _tb_unitMapper);
  }

  @override
  Future<int> insertUnit(Unit unit) {
    return _unitInsertionAdapter.insertAndReturnId(
        unit, sqflite.ConflictAlgorithm.abort);
  }

  @override
  Future<List<int>> insertList(List<Unit> unitList) {
    return _unitInsertionAdapter.insertListAndReturnIds(
        unitList, sqflite.ConflictAlgorithm.abort);
  }

  @override
  Future<int> updateUnit(Unit unit) {
    return _unitUpdateAdapter.updateAndReturnChangedRows(
        unit, sqflite.ConflictAlgorithm.abort);
  }

  @override
  Future<int> updateList(List<Unit> unitList) {
    return _unitUpdateAdapter.updateListAndReturnChangedRows(
        unitList, sqflite.ConflictAlgorithm.abort);
  }

  @override
  Future<int> deleteUnit(Unit unit) {
    return _unitDeletionAdapter.deleteAndReturnChangedRows(unit);
  }

  @override
  Future<int> deleteList(List<Unit> unitList) {
    return _unitDeletionAdapter.deleteListAndReturnChangedRows(unitList);
  }
}

class _$ReagentDAO extends ReagentDAO {
  _$ReagentDAO(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database, changeListener),
        _reagentInsertionAdapter = InsertionAdapter(
            database,
            'tb_reagent',
            (Reagent item) => <String, dynamic>{
                  'id_reagent': item.id,
                  'description': item.description,
                  'id_unit': item.unitId
                },
            changeListener),
        _reagentUpdateAdapter = UpdateAdapter(
            database,
            'tb_reagent',
            ['id_reagent'],
            (Reagent item) => <String, dynamic>{
                  'id_reagent': item.id,
                  'description': item.description,
                  'id_unit': item.unitId
                },
            changeListener),
        _reagentDeletionAdapter = DeletionAdapter(
            database,
            'tb_reagent',
            ['id_reagent'],
            (Reagent item) => <String, dynamic>{
                  'id_reagent': item.id,
                  'description': item.description,
                  'id_unit': item.unitId
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  static final _tb_reagentMapper = (Map<String, dynamic> row) => Reagent(
      row['id_reagent'] as int,
      row['description'] as String,
      row['id_unit'] as int);

  final InsertionAdapter<Reagent> _reagentInsertionAdapter;

  final UpdateAdapter<Reagent> _reagentUpdateAdapter;

  final DeletionAdapter<Reagent> _reagentDeletionAdapter;

  @override
  Future<List<Reagent>> findAll() async {
    return _queryAdapter.queryList('SELECT * FROM tb_reagent',
        mapper: _tb_reagentMapper);
  }

  @override
  Stream<List<Reagent>> findAllStream() {
    return _queryAdapter.queryListStream('SELECT * FROM tb_reagent',
        tableName: 'tb_reagent', mapper: _tb_reagentMapper);
  }

  @override
  Future<Reagent> findElementsById(int id) async {
    return _queryAdapter.query('SELECT * FROM tb_reagent WHERE id_reagent = ?',
        arguments: <dynamic>[id], mapper: _tb_reagentMapper);
  }

  @override
  Future<Reagent> deleteById(int id) async {
    return _queryAdapter.query('DELETE FROM tb_reagent WHERE id_reagent = ?',
        arguments: <dynamic>[id], mapper: _tb_reagentMapper);
  }

  @override
  Future<List<Reagent>> incompatibleReagentIsUsed(int id) async {
    return _queryAdapter.queryList(
        'SELECT * FROM tb_incompatible_reagent WHERE id_incompatible_reagent = ?',
        arguments: <dynamic>[id],
        mapper: _tb_reagentMapper);
  }

  @override
  Future<List<Reagent>> isUsed(int id) async {
    return _queryAdapter.queryList(
        'SELECT * FROM tb_formula_reagent WHERE id_reagent = ?',
        arguments: <dynamic>[id],
        mapper: _tb_reagentMapper);
  }

  @override
  Future<int> insertReagent(Reagent reagent) {
    return _reagentInsertionAdapter.insertAndReturnId(
        reagent, sqflite.ConflictAlgorithm.abort);
  }

  @override
  Future<List<int>> insertList(List<Reagent> reagentList) {
    return _reagentInsertionAdapter.insertListAndReturnIds(
        reagentList, sqflite.ConflictAlgorithm.abort);
  }

  @override
  Future<int> updateReagent(Reagent reagent) {
    return _reagentUpdateAdapter.updateAndReturnChangedRows(
        reagent, sqflite.ConflictAlgorithm.abort);
  }

  @override
  Future<int> updateList(List<Reagent> reagentList) {
    return _reagentUpdateAdapter.updateListAndReturnChangedRows(
        reagentList, sqflite.ConflictAlgorithm.abort);
  }

  @override
  Future<int> deleteReagent(Reagent reagent) {
    return _reagentDeletionAdapter.deleteAndReturnChangedRows(reagent);
  }

  @override
  Future<int> deleteList(List<Reagent> reagentList) {
    return _reagentDeletionAdapter.deleteListAndReturnChangedRows(reagentList);
  }
}

class _$FormulaDAO extends FormulaDAO {
  _$FormulaDAO(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database, changeListener),
        _formulaInsertionAdapter = InsertionAdapter(
            database,
            'tb_formula',
            (Formula item) => <String, dynamic>{
                  'id_formula': item.id,
                  'name': item.name,
                  'description': item.description,
                  'preparation_mode': item.preparationMode
                },
            changeListener),
        _formulaUpdateAdapter = UpdateAdapter(
            database,
            'tb_formula',
            ['id_formula'],
            (Formula item) => <String, dynamic>{
                  'id_formula': item.id,
                  'name': item.name,
                  'description': item.description,
                  'preparation_mode': item.preparationMode
                },
            changeListener),
        _formulaDeletionAdapter = DeletionAdapter(
            database,
            'tb_formula',
            ['id_formula'],
            (Formula item) => <String, dynamic>{
                  'id_formula': item.id,
                  'name': item.name,
                  'description': item.description,
                  'preparation_mode': item.preparationMode
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  static final _tb_formulaMapper = (Map<String, dynamic> row) => Formula(
      row['id_formula'] as int,
      row['name'] as String,
      row['description'] as String,
      row['preparation_mode'] as String);

  final InsertionAdapter<Formula> _formulaInsertionAdapter;

  final UpdateAdapter<Formula> _formulaUpdateAdapter;

  final DeletionAdapter<Formula> _formulaDeletionAdapter;

  @override
  Future<List<Formula>> findAll() async {
    return _queryAdapter.queryList('SELECT * FROM tb_formula',
        mapper: _tb_formulaMapper);
  }

  @override
  Stream<List<Formula>> findAllStream() {
    return _queryAdapter.queryListStream('SELECT * FROM tb_formula',
        tableName: 'tb_formula', mapper: _tb_formulaMapper);
  }

  @override
  Future<Formula> findElementsById(int id) async {
    return _queryAdapter.query('SELECT * FROM tb_formula WHERE id_formula = ?',
        arguments: <dynamic>[id], mapper: _tb_formulaMapper);
  }

  @override
  Future<void> deleteById(int id) async {
    await _queryAdapter.queryNoReturn(
        'DELETE FROM tb_formula WHERE id_formula = ?',
        arguments: <dynamic>[id]);
  }

  @override
  Future<int> insertFormula(Formula formula) {
    return _formulaInsertionAdapter.insertAndReturnId(
        formula, sqflite.ConflictAlgorithm.abort);
  }

  @override
  Future<List<int>> insertList(List<Formula> formulaList) {
    return _formulaInsertionAdapter.insertListAndReturnIds(
        formulaList, sqflite.ConflictAlgorithm.abort);
  }

  @override
  Future<int> updateFormula(Formula formula) {
    return _formulaUpdateAdapter.updateAndReturnChangedRows(
        formula, sqflite.ConflictAlgorithm.abort);
  }

  @override
  Future<int> updateList(List<Formula> formulaList) {
    return _formulaUpdateAdapter.updateListAndReturnChangedRows(
        formulaList, sqflite.ConflictAlgorithm.abort);
  }

  @override
  Future<int> deleteFormula(Formula formula) {
    return _formulaDeletionAdapter.deleteAndReturnChangedRows(formula);
  }

  @override
  Future<int> deleteList(List<Formula> formulaList) {
    return _formulaDeletionAdapter.deleteListAndReturnChangedRows(formulaList);
  }
}

class _$FormulaReagentDAO extends FormulaReagentDAO {
  _$FormulaReagentDAO(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database, changeListener),
        _formulaReagentInsertionAdapter = InsertionAdapter(
            database,
            'tb_formula_reagent',
            (FormulaReagent item) => <String, dynamic>{
                  'id_formula': item.formulaID,
                  'id_reagent': item.reagentID
                },
            changeListener),
        _formulaReagentUpdateAdapter = UpdateAdapter(
            database,
            'tb_formula_reagent',
            ['id_formula', 'id_reagent'],
            (FormulaReagent item) => <String, dynamic>{
                  'id_formula': item.formulaID,
                  'id_reagent': item.reagentID
                },
            changeListener),
        _formulaReagentDeletionAdapter = DeletionAdapter(
            database,
            'tb_formula_reagent',
            ['id_formula', 'id_reagent'],
            (FormulaReagent item) => <String, dynamic>{
                  'id_formula': item.formulaID,
                  'id_reagent': item.reagentID
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  static final _tb_formula_reagentMapper = (Map<String, dynamic> row) =>
      FormulaReagent(row['id_formula'] as int, row['id_reagent'] as int);

  static final _tb_reagentMapper = (Map<String, dynamic> row) => Reagent(
      row['id_reagent'] as int,
      row['description'] as String,
      row['id_unit'] as int);

  final InsertionAdapter<FormulaReagent> _formulaReagentInsertionAdapter;

  final UpdateAdapter<FormulaReagent> _formulaReagentUpdateAdapter;

  final DeletionAdapter<FormulaReagent> _formulaReagentDeletionAdapter;

  @override
  Future<List<FormulaReagent>> findAll() async {
    return _queryAdapter.queryList('SELECT * FROM tb_formula_reagent',
        mapper: _tb_formula_reagentMapper);
  }

  @override
  Stream<List<FormulaReagent>> findAllStream() {
    return _queryAdapter.queryListStream('SELECT * FROM tb_formula_reagent',
        tableName: 'tb_formula_reagent', mapper: _tb_formula_reagentMapper);
  }

  @override
  Future<List<Reagent>> findElementsById(int formulaId) async {
    return _queryAdapter.queryList(
        'SELECT r.* FROM tb_formula_reagent fr INNER JOIN tb_reagent r on r.id_reagent = fr.id_reagent WHERE fr.id_formula = ?',
        arguments: <dynamic>[formulaId],
        mapper: _tb_reagentMapper);
  }

  @override
  Future<FormulaReagent> deleteById(int formulaId) async {
    return _queryAdapter.query(
        'DELETE FROM tb_formula_reagent WHERE id_formula = ?',
        arguments: <dynamic>[formulaId],
        mapper: _tb_formula_reagentMapper);
  }

  @override
  Future<int> insertFormulaReagent(FormulaReagent formulaReagent) {
    return _formulaReagentInsertionAdapter.insertAndReturnId(
        formulaReagent, sqflite.ConflictAlgorithm.abort);
  }

  @override
  Future<List<int>> insertList(List<FormulaReagent> formulaReagentList) {
    return _formulaReagentInsertionAdapter.insertListAndReturnIds(
        formulaReagentList, sqflite.ConflictAlgorithm.abort);
  }

  @override
  Future<int> updateFormulaReagent(FormulaReagent formulaReagent) {
    return _formulaReagentUpdateAdapter.updateAndReturnChangedRows(
        formulaReagent, sqflite.ConflictAlgorithm.abort);
  }

  @override
  Future<int> updateList(List<FormulaReagent> formulaReagentList) {
    return _formulaReagentUpdateAdapter.updateListAndReturnChangedRows(
        formulaReagentList, sqflite.ConflictAlgorithm.abort);
  }

  @override
  Future<int> deleteFormulaReagent(FormulaReagent formulaReagent) {
    return _formulaReagentDeletionAdapter
        .deleteAndReturnChangedRows(formulaReagent);
  }

  @override
  Future<int> deleteList(List<FormulaReagent> formulaReagentList) {
    return _formulaReagentDeletionAdapter
        .deleteListAndReturnChangedRows(formulaReagentList);
  }
}

class _$IncompatibleReagentDAO extends IncompatibleReagentDAO {
  _$IncompatibleReagentDAO(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database, changeListener),
        _incompatibleReagentInsertionAdapter = InsertionAdapter(
            database,
            'tb_incompatible_reagent',
            (IncompatibleReagent item) => <String, dynamic>{
                  'id_reagent': item.reagentID,
                  'id_incompatible_reagent': item.incompatibleReagentID
                },
            changeListener),
        _incompatibleReagentUpdateAdapter = UpdateAdapter(
            database,
            'tb_incompatible_reagent',
            ['id_reagent', 'id_incompatible_reagent'],
            (IncompatibleReagent item) => <String, dynamic>{
                  'id_reagent': item.reagentID,
                  'id_incompatible_reagent': item.incompatibleReagentID
                },
            changeListener),
        _incompatibleReagentDeletionAdapter = DeletionAdapter(
            database,
            'tb_incompatible_reagent',
            ['id_reagent', 'id_incompatible_reagent'],
            (IncompatibleReagent item) => <String, dynamic>{
                  'id_reagent': item.reagentID,
                  'id_incompatible_reagent': item.incompatibleReagentID
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  static final _tb_incompatible_reagentMapper = (Map<String, dynamic> row) =>
      IncompatibleReagent(
          row['id_reagent'] as int, row['id_incompatible_reagent'] as int);

  static final _tb_reagentMapper = (Map<String, dynamic> row) => Reagent(
      row['id_reagent'] as int,
      row['description'] as String,
      row['id_unit'] as int);

  final InsertionAdapter<IncompatibleReagent>
      _incompatibleReagentInsertionAdapter;

  final UpdateAdapter<IncompatibleReagent> _incompatibleReagentUpdateAdapter;

  final DeletionAdapter<IncompatibleReagent>
      _incompatibleReagentDeletionAdapter;

  @override
  Future<List<IncompatibleReagent>> findAll() async {
    return _queryAdapter.queryList('SELECT * FROM tb_incompatible_reagent',
        mapper: _tb_incompatible_reagentMapper);
  }

  @override
  Stream<List<IncompatibleReagent>> findAllStream() {
    return _queryAdapter.queryListStream(
        'SELECT * FROM tb_incompatible_reagent',
        tableName: 'tb_incompatible_reagent',
        mapper: _tb_incompatible_reagentMapper);
  }

  @override
  Future<List<Reagent>> findElementsById(int reagentID) async {
    return _queryAdapter.queryList(
        'SELECT r.* FROM tb_incompatible_reagent ir INNER JOIN tb_reagent r on r.id_reagent = ir.id_incompatible_reagent WHERE ir.id_reagent = ?',
        arguments: <dynamic>[reagentID],
        mapper: _tb_reagentMapper);
  }

  @override
  Future<IncompatibleReagent> deleteById(int reagentID) async {
    return _queryAdapter.query(
        'DELETE FROM tb_incompatible_reagent WHERE id_reagent = ?',
        arguments: <dynamic>[reagentID],
        mapper: _tb_incompatible_reagentMapper);
  }

  @override
  Future<int> insertIncompatibleReagent(
      IncompatibleReagent incompatibleReagent) {
    return _incompatibleReagentInsertionAdapter.insertAndReturnId(
        incompatibleReagent, sqflite.ConflictAlgorithm.abort);
  }

  @override
  Future<List<int>> insertList(
      List<IncompatibleReagent> incompatibleReagentList) {
    return _incompatibleReagentInsertionAdapter.insertListAndReturnIds(
        incompatibleReagentList, sqflite.ConflictAlgorithm.abort);
  }

  @override
  Future<int> updateIncompatibleReagent(
      IncompatibleReagent incompatibleReagent) {
    return _incompatibleReagentUpdateAdapter.updateAndReturnChangedRows(
        incompatibleReagent, sqflite.ConflictAlgorithm.abort);
  }

  @override
  Future<int> updateList(List<IncompatibleReagent> incompatibleReagentList) {
    return _incompatibleReagentUpdateAdapter.updateListAndReturnChangedRows(
        incompatibleReagentList, sqflite.ConflictAlgorithm.abort);
  }

  @override
  Future<int> deleteIncompatibleReagent(
      IncompatibleReagent incompatibleReagent) {
    return _incompatibleReagentDeletionAdapter
        .deleteAndReturnChangedRows(incompatibleReagent);
  }

  @override
  Future<int> deleteList(List<IncompatibleReagent> incompatibleReagentList) {
    return _incompatibleReagentDeletionAdapter
        .deleteListAndReturnChangedRows(incompatibleReagentList);
  }
}
