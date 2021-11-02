import 'package:bytebank/models/contact_model.dart';
import 'package:bytebank/models/transaction_model.dart';
import 'package:flutter/material.dart';

class TransactionsList extends StatelessWidget {
  final List<TransactionModel> transactions = [];

  @override
  Widget build(BuildContext context) {
    transactions.add(
      TransactionModel(
        100.0,
        ContactModel(id: 0, name: 'Alex', accountNumber: 1000),
      ),
    );
    return Scaffold(
      appBar: AppBar(
        title: Text('Transactions'),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          final TransactionModel transaction = transactions[index];
          return Card(
            child: ListTile(
              leading: Icon(Icons.monetization_on),
              title: Text(
                transaction.value.toString(),
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                transaction.contact.accountNumber.toString(),
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
            ),
          );
        },
        itemCount: transactions.length,
      ),
    );
  }
}
