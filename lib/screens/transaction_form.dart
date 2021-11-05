import 'dart:async';
import 'dart:io';

import 'package:bytebank/components/progress.dart';
import 'package:bytebank/components/response_dialog.dart';
import 'package:bytebank/components/transaction_auth_dialog.dart';
import 'package:bytebank/http/webclients/transaction_webclient.dart';
import 'package:bytebank/models/contact_model.dart';
import 'package:bytebank/models/transaction_model.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class TransactionForm extends StatefulWidget {
  final ContactModel contact;

  TransactionForm({
    required this.contact,
  });

  @override
  _TransactionFormState createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final TextEditingController _valueController = TextEditingController();
  final TransactionWebClient _webClient = TransactionWebClient();
  final String _transactionId = Uuid().v4();

  bool _visible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New transaction'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Visibility(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Progress(message: 'Sending Transfer...'),
                ),
                visible: _visible,
              ),
              Text(
                widget.contact.name,
                style: TextStyle(
                  fontSize: 24.0,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Text(
                  widget.contact.accountNumber.toString(),
                  style: TextStyle(
                    fontSize: 32.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: TextField(
                  controller: _valueController,
                  style: TextStyle(fontSize: 24.0),
                  decoration: InputDecoration(labelText: 'Value'),
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: SizedBox(
                  width: double.maxFinite,
                  child: ElevatedButton(
                    child: Text('Transfer'),
                    onPressed: () async {
                      final double value = double.parse(_valueController.text);
                      final transactionCreated = TransactionModel(
                        id: _transactionId,
                        value: value,
                        contact: widget.contact,
                      );

                      showDialog(
                        context: context,
                        builder: (contextDialog) => TransactionAuthDialog(
                          onConfirm: (String password) async {
                            await _saveTransaction(
                              transactionCreated,
                              password,
                              context,
                            );
                          },
                        ),
                      );
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _saveTransaction(
    TransactionModel transactionCreated,
    String password,
    BuildContext context,
  ) async {
    setState(() => _visible = true);

    await _webClient.save(transactionCreated, password).catchError(
      (e) {
        _showFailureMessage(
          context,
          message: 'request take too long',
        );
      },
      test: (e) => e is SocketException,
    ).catchError(
      (e) {
        _showFailureMessage(
          context,
          message: e.message,
        );
      },
      test: (e) => e is HttpException,
    ).catchError(
      (e) {
        _showFailureMessage(
          context,
          message: 'Unknown Error',
        );
      },
      test: (e) => e is Exception,
    ).whenComplete(() => setState(() => _visible = false));

    await _showSuccessfulDialog(context);
  }

  Future<void> _showSuccessfulDialog(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (contextDialog) => SuccessDialog('Transaction Completed'),
    );
    Navigator.of(context).pop();
  }

  void _showFailureMessage(BuildContext context, {required String message}) {
    showDialog(
      context: context,
      builder: (contextDialog) => FailureDialog(message),
    );
  }
}
