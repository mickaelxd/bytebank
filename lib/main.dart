import 'package:flutter/material.dart';

void main() => runApp(BytebankApp());

class BytebankApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: TransferList(),
      ),
    );
  }
}

class TransferForm extends StatelessWidget {
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
            onPressed: () => _createTransfer(),
          ),
        ],
      ),
    );
  }

  void _createTransfer() {
    print(_controllerAccountNumber.text);
    print(_controllerValue.text);
  }
}

class ByteBankTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String hintText;
  final IconData? customIcon;

  ByteBankTextField({
    required this.labelText,
    required this.hintText,
    required this.controller,
    this.customIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        controller: controller,
        style: TextStyle(
          fontSize: 24.0,
        ),
        decoration: InputDecoration(
          icon: customIcon != null ? Icon(customIcon) : null,
          labelText: labelText,
          hintText: hintText,
        ),
        keyboardType: TextInputType.number,
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
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return TransferForm();
          }));
        },
      ),
      appBar: AppBar(
        title: Text('Transfers'),
      ),
    );
  }
}

class TransferItem extends StatelessWidget {
  final String value;
  final String accountNumber;

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
