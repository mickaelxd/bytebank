import 'package:bytebank/components/byte_bank_text_field.dart';
import 'package:bytebank/models/contact_model.dart';
import 'package:flutter/material.dart';

class ContactsForm extends StatefulWidget {
  @override
  _ContactsFormState createState() => _ContactsFormState();
}

class _ContactsFormState extends State<ContactsForm> {
  final TextEditingController _controllerAccountNumber =
      TextEditingController();

  final TextEditingController _controllername = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Contact'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ByteBankTextField(
              controller: _controllername,
              labelText: 'Full Name',
              hintText: '...',
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: ByteBankTextField(
                controller: _controllerAccountNumber,
                labelText: 'Account Number',
                hintText: '0000',
                keyboardType: TextInputType.number,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: SizedBox(
                width: double.maxFinite,
                child: ElevatedButton(
                  child: Text('Create'),
                  onPressed: () => _createContact(context),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _createContact(BuildContext context) {
    final contact = ContactModel(
      name: _controllername.text,
      accountNumber: int.parse(_controllerAccountNumber.text),
    );

    Navigator.pop(context, contact);
  }
}
