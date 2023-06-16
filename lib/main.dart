import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';
import 'controller.dart';
import 'screen/dashboard.dart';
import 'variables.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  database = openDatabase(
    join(await getDatabasesPath(), 'crypto.db'),
    onCreate: (db, version) {
      return db.execute(
        'CREATE TABLE logs(rowid INTEGER PRIMARY KEY, time TEXT, name TEXT, rate REAL)',
      );
    },
    version: 2,
  );
  runApp(
    ChangeNotifierProvider(
      create: (context) => Controller(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: appName,
        home: const Dashboard(),
      ),
    ),
  );
}
