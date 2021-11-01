import 'package:bytebank/models/contact_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> createDatabase() async {
  final String dbPath = await getDatabasesPath();
  final String path = join(dbPath, 'bytebank.db');

  return openDatabase(path, onCreate: (db, version) {
    db.execute('CREATE TABLE contacts('
        'id INTEGER PRIMARY KEY, '
        'name TEXT, '
        'account_number INTEGER)');
  }, version: 1);
}

Future<int> save(ContactModel contact) async {
  final Database db = await createDatabase();
  final Map<String, dynamic> contactMap = Map();
  contactMap['id'] = contact.id;
  contactMap['name'] = contact.name;
  contactMap['account_number'] = contact.accountNumber;

  return db.insert('contacts', contactMap);
}

Future<List<ContactModel>> findAll() async {
  final Database db = await createDatabase();
  final List<Map<String, dynamic>> maps = await db.query('contacts');
  List<ContactModel> contacts = [];
  for (Map<String, dynamic> map in maps) {
    final ContactModel contact = ContactModel(
      name: map['name'],
      accountNumber: map['account_number'],
    );
    contacts.add(contact);
  }

  return contacts;
}
