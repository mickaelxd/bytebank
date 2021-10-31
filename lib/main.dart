import 'package:flutter/material.dart';

void main() => runApp(BytebankApp());

class BytebankApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: TransferForm(),
      ),
    );
  }
}

class TransferForm extends StatelessWidget {
  
final TextEditingController _controllerAccountNumber = TextEditingController();
final TextEditingController _controllerValue = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Creating Transfer'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _controllerAccountNumber,
              style: TextStyle(
                fontSize: 24.0,
              ),
              decoration: InputDecoration(
                labelText: 'Account Number',
                hintText: '0000',
              ),
              keyboardType: TextInputType.number,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _controllerValue,
              style: TextStyle(
                fontSize: 24.0,
              ),
              decoration: InputDecoration(
                icon: Icon(Icons.monetization_on),
                labelText: 'Value',
                hintText: '0.00',
              ),
              keyboardType: TextInputType.number,
            ),
          ),
          ElevatedButton(
            child: Text('Confirm'),
            onPressed: () {
              print(_controllerAccountNumber.text);
              print(_controllerValue.text);
            },
          ),
        ],
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
    return Scaffold(
      body: ListView(
        children: [
          TransferItem(
            value: '200',
            accountNumber: '1230-3',
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {},
      ),
      appBar: AppBar(
        title: Text('Transfers'),
      ),
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
