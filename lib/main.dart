import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Transfers'),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {},
        ),
        body: TransferList(),
      ),
    );
  }
}

class TransferList extends StatelessWidget {
  const TransferList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        TransferItem(
          value: '200',
          accountNumber: '1230-3',
        ),
      ],
    );
  }
}

class TransferItem extends StatelessWidget {
  String value;
  String accountNumber;

  TransferItem({
    required this.value,
    required this.accountNumber,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(Icons.monetization_on),
        title: Text('R\$ $value,00'),
        subtitle: Text(accountNumber),
      ),
    );
  }
}
