import 'package:bytebank/models/contact_model.dart';
import 'package:flutter/material.dart';

class ContactItem extends StatelessWidget {
  final ContactModel _contact;

  ContactItem(this._contact);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(
          _contact.fullName.toString(),
        ),
        subtitle: Text(
          _contact.accountNumber.toString(),
        ),
      ),
    );
  }
}
