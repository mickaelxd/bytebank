
import 'package:bytebank/components/byte_bank_text_field.dart';
import 'package:bytebank/models/transfer_model.dart';
import 'package:flutter/material.dart';

class TransferForm extends StatefulWidget {
  @override
  _TransferFormState createState() => _TransferFormState();
}

class _TransferFormState extends State<TransferForm> {
  final TextEditingController _controllerAccountNumber =
      TextEditingController();

  final TextEditingController _controllerValue = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Creating Transfer'),
      ),
      body: Column(
        children: [
          ByteBankTextField(
            controller: _controllerAccountNumber,
            labelText: 'Account Number',
            hintText: '0000',
          ),
          ByteBankTextField(
            controller: _controllerValue,
            labelText: 'Value',
            hintText: '0.00',
            customIcon: Icons.monetization_on,
          ),
          ElevatedButton(
            child: Text('Confirm'),
            onPressed: () => _createTransfer(context),
          ),
        ],
      ),
    );
  }

  void _createTransfer(BuildContext context) {
    final transfer = TransferModel(
      value: double.parse(_controllerValue.text),
      accountNumber: int.parse(_controllerAccountNumber.text),
    );

    Navigator.pop(context, transfer);
  }
}
