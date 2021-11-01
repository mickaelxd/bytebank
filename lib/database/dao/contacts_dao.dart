import 'package:bytebank/database/app_database.dart';
import 'package:bytebank/models/contact_model.dart';
import 'package:sqflite/sqlite_api.dart';

class ContactsDao {
  static const String tableSQL = 'CREATE TABLE $_contactsTable('
      '$_id INTEGER PRIMARY KEY, '
      '$_name TEXT, '
      '$_accountNumber INTEGER)';

  static const String _contactsTable = 'contacts';
  static const String _id = 'id';
  static const String _name = 'name';
  static const String _accountNumber = 'account_number';

  Future<int> save(ContactModel contact) async {
    final Database db = await createDatabase();
    Map<String, dynamic> contactMap = _toMap(contact);

    return db.insert(_contactsTable, contactMap);
  }

  Future<List<ContactModel>> findAll() async {
    final Database db = await createDatabase();
    final List<Map<String, dynamic>> maps = await db.query(_contactsTable);
    List<ContactModel> contacts = _toList(maps);

    return contacts;
  }

  Map<String, dynamic> _toMap(ContactModel contact) {
    final Map<String, dynamic> contactMap = Map();
    contactMap[_id] = contact.id;
    contactMap[_name] = contact.name;
    contactMap[_accountNumber] = contact.accountNumber;
    return contactMap;
  }

  List<ContactModel> _toList(List<Map<String, dynamic>> rows) {
    List<ContactModel> contacts = [];
    for (Map<String, dynamic> row in rows) {
      final ContactModel contact = ContactModel(
        name: row[_name],
        accountNumber: row[_accountNumber],
      );
      contacts.add(contact);
    }
    return contacts;
  }
}
