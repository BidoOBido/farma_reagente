import 'dart:async';

import 'package:floor/floor.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import 'package:farma_reagente/dao/unit_dao.dart';
import 'package:farma_reagente/dao/formula_dao.dart';
import 'package:farma_reagente/dao/formula_reagent_dao.dart';
import 'package:farma_reagente/dao/incompatible_reagent_dao.dart';
import 'package:farma_reagente/dao/reagent_dao.dart';

import 'package:farma_reagente/models/unit.dart';
import 'package:farma_reagente/models/formula.dart';
import 'package:farma_reagente/models/formula_reagent.dart';
import 'package:farma_reagente/models/incompatible_reagent.dart';
import 'package:farma_reagente/models/reagent.dart';

part 'app_database.g.dart';

@Database(version: 1, entities: [Unit, Reagent, Formula, FormulaReagent, IncompatibleReagent])
abstract class AppDatabase extends FloorDatabase {
  UnitDAO get unitDAO;
  ReagentDAO get reagentDAO;
  FormulaDAO get formulaDAO;
  FormulaReagentDAO get formulaReagentDAO;
  IncompatibleReagentDAO get incompatibleReagentDAO;
}

Future<AppDatabase> getDatabase() async {
  return (await $FloorAppDatabase.databaseBuilder('farma_reagente.db').build());
}
