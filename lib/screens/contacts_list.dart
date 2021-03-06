import 'package:bytebank/components/centered_message.dart';
import 'package:bytebank/components/contact_item.dart';
import 'package:bytebank/components/progress.dart';
import 'package:bytebank/database/dao/contacts_dao.dart';
import 'package:bytebank/models/contact_model.dart';
import 'package:bytebank/screens/contacts_form.dart';
import 'package:bytebank/screens/transaction_form.dart';
import 'package:flutter/material.dart';

class ContactsList extends StatefulWidget {
  ContactsList({
    Key? key,
  }) : super(key: key);

  @override
  _ContactsListState createState() => _ContactsListState();
}

class _ContactsListState extends State<ContactsList> {
  final ContactsDao _dao = ContactsDao();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ContactsForm()),
          );
          setState(() {});
        },
      ),
      appBar: AppBar(
        title: Text('Transfer'),
      ),
      body: FutureBuilder<List<ContactModel>>(
        initialData: [],
        future: _dao.findAll(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              break;
            case ConnectionState.waiting:
              return Progress();
            case ConnectionState.active:
              break;
            case ConnectionState.done:
              final _contacts = snapshot.data;

              if (_contacts == null || _contacts.isEmpty) {
                return CenteredMessage(
                  message: 'No contacts found',
                  icon: Icons.warning,
                );
              }

              return ListView.builder(
                itemCount: _contacts.length,
                itemBuilder: (context, index) {
                  final _contact = _contacts[index];

                  return ContactItem(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => TransactionForm(
                            contact: _contact,
                          ),
                        ),
                      );
                    },
                    contact: ContactModel(
                      name: _contact.name,
                      accountNumber: _contact.accountNumber,
                    ),
                  );
                },
              );
          }

          return CenteredMessage(message: 'Unknown Error');
        },
      ),
    );
  }
}

