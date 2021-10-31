import 'package:bytebank/components/transfer_item.dart';
import 'package:bytebank/models/transfer_model.dart';
import 'package:bytebank/screens/transfer_form.dart';
import 'package:flutter/material.dart';

class TransferList extends StatefulWidget {
  final List<TransferModel> _transfers = [];

  TransferList({
    Key? key,
  }) : super(key: key);

  @override
  _TransferListState createState() => _TransferListState();
}

class _TransferListState extends State<TransferList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => TransferForm()),
          ).then((transfer) => _updateList(transfer));
        },
      ),
      appBar: AppBar(
        title: Text('Transfers'),
      ),
      body: ListView.builder(
        itemCount: widget._transfers.length,
        itemBuilder: (context, index) {
          final _transfer = widget._transfers[index];

          return TransferItem(
            TransferModel(
              value: _transfer.value,
              accountNumber: _transfer.accountNumber,
            ),
          );
        },
      ),
    );
  }

  void _updateList(TransferModel? transfer) {
    if (transfer != null) {
      setState(() {
        widget._transfers.add(transfer);
      });
    }
  }
}
