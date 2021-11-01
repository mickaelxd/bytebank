import 'package:bytebank/components/contact_item.dart';
import 'package:bytebank/models/contact_model.dart';
import 'package:bytebank/screens/contacts_form.dart';
import 'package:flutter/material.dart';

class ContactsList extends StatefulWidget {
  final List<ContactModel> _contacts = [];

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
          ).then((contact) => _updateList(contact));
        },
      ),
      appBar: AppBar(
        title: Text('Contacts'),
      ),
      body: ListView.builder(
        itemCount: widget._contacts.length,
        itemBuilder: (context, index) {
          final _contact = widget._contacts[index];

          return ContactItem(
            ContactModel(
              name: _contact.name,
              accountNumber: _contact.accountNumber,
            ),
          );
        },
      ),
    );
  }

  void _updateList(ContactModel? contact) {
    if (contact != null) {
      setState(() {
        widget._contacts.add(contact);
      });
    }
  }
}
