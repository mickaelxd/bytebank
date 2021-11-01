import 'package:bytebank/database/dao/contacts_dao.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> createDatabase() async {
  final String dbPath = await getDatabasesPath();
  final String path = join(dbPath, 'bytebank.db');

  return openDatabase(path, onCreate: (db, version) {
    db.execute(ContactsDao.tableSQL);
  }, version: 1);
}
