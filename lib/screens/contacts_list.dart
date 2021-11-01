import 'package:bytebank/components/contact_item.dart';
import 'package:bytebank/database/app_database.dart';
import 'package:bytebank/models/contact_model.dart';
import 'package:bytebank/screens/contacts_form.dart';
import 'package:flutter/material.dart';

class ContactsList extends StatefulWidget {
  ContactsList({
    Key? key,
  }) : super(key: key);

  @override
  _ContactsListState createState() => _ContactsListState();
}

class _ContactsListState extends State<ContactsList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ContactsForm()),
          ).then((value) {
            setState(() {});
          });
        },
      ),
      appBar: AppBar(
        title: Text('Contacts'),
      ),
      body: FutureBuilder<List<ContactModel>>(
        initialData: [],
        future: findAll(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              break;
            case ConnectionState.waiting:
              return Center(
                child: CircularProgressIndicator(),
              );
            case ConnectionState.active:
              break;
            case ConnectionState.done:
              final _contacts = snapshot.data;

              if (_contacts!.isEmpty) {
                return Center(
                  child: Text('No contacts found'),
                );
              }

              return ListView.builder(
                itemCount: _contacts.length,
                itemBuilder: (context, index) {
                  final _contact = _contacts[index];

                  return ContactItem(
                    ContactModel(
                      name: _contact.name,
                      accountNumber: _contact.accountNumber,
                    ),
                  );
                },
              );
          }

          return Container();
        },
      ),
    );
  }
}
