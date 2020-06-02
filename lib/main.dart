import 'package:farma_reagente/database/app_database.dart';
import 'package:farma_reagente/screens/formula/list.dart';
import 'package:farma_reagente/screens/formula/register.dart';
import 'package:farma_reagente/screens/login.dart';
import 'package:farma_reagente/screens/reagent/list.dart';
import 'package:farma_reagente/screens/reagent/register.dart';
import 'package:farma_reagente/screens/unit/list.dart';
import 'package:farma_reagente/screens/unit/register.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:internationalization/internationalization.dart';
import 'constants/app_strings.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Internationalization.loadConfigurations();
  runApp(FarmaReagenteApp(database: (await getDatabase())));
}

class FarmaReagenteApp extends StatelessWidget {
  final AppDatabase database;

  const FarmaReagenteApp({
    Key key,
    @required this.database,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppStrings.appName,
      theme: ThemeData(
        primaryColor: Colors.green[400],
        accentColor: Colors.blue[700],
        buttonTheme: ButtonThemeData(
          textTheme: ButtonTextTheme.primary,
        ),
      ),
      initialRoute: AppStrings.routeUnitList,
      routes: {
        //AppStrings.routeMain: (context) => Login(),
        AppStrings.routeUnitList: (context) => UnitList(database: database),
        AppStrings.routeReagentList: (context) => ReagentList(database: database),
        AppStrings.routeFormulaList: (context) => FormulaList(database: database),
        AppStrings.routeUnitRegister: (context) => UnitRegister(database: database),
        AppStrings.routeReagentRegister: (context) => ReagentRegister(database: database),
        AppStrings.routeFormulaRegister: (context) => FormulaRegister(database: database),
      },
      supportedLocales: suportedLocales,
      localizationsDelegates: [
        Internationalization.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
    );
  }
}
