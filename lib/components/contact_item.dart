import 'package:bytebank/models/contact_model.dart';
import 'package:flutter/material.dart';

class ContactItem extends StatelessWidget {
  final ContactModel contact;
  final void Function()? onTap;

  ContactItem({
    required this.contact,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: onTap,
        title: Text(
          contact.name.toString(),
        ),
        subtitle: Text(
          contact.accountNumber.toString(),
        ),
      ),
    );
  }
}
