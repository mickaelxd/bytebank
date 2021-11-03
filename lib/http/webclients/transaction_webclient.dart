import 'dart:convert';

import 'package:bytebank/http/webclient.dart';
import 'package:bytebank/models/contact_model.dart';
import 'package:bytebank/models/transaction_model.dart';
import 'package:http/http.dart';

class TransactionWebClient {
  Future<List<TransactionModel>> findAll() async {
    try {
      final Response response = await client
          .get(Uri.parse('$baseUrl/transactions'))
          .timeout(Duration(seconds: 15));

      List<TransactionModel> transactions = _toTransactions(response);

      return transactions;
    } on Exception catch (e) {
      print(e);
      return [];
    }
  }

  Future<TransactionModel?> save(TransactionModel transaction) async {
    try {
      Map<String, dynamic> transactionMap = _toMap(transaction);

      final transactionJson = jsonEncode(transactionMap);

      final Response response = await client.post(
        Uri.parse('$baseUrl/transactions'),
        body: transactionJson,
        headers: {
          'Content-type': 'application/json',
          'password': '1000',
        },
      );

      Map<String, dynamic> decodedResponse = jsonDecode(response.body);

      final transactionResponse = TransactionModel(
        value: decodedResponse['value'],
        contact: ContactModel(
          id: 0,
          name: decodedResponse['contact']['name'],
          accountNumber: decodedResponse['contact']['accountNumber'],
        ),
      );

      return transactionResponse;
    } on Exception catch (e) {
      print(e);
      return null;
    }
  }

  Map<String, dynamic> _toMap(TransactionModel transaction) {
    final Map<String, dynamic> transactionMap = {
      'value': transaction.value,
      'contact': {
        'name': transaction.contact.name,
        'accountNumber': transaction.contact.accountNumber,
      },
    };
    return transactionMap;
  }

  List<TransactionModel> _toTransactions(Response response) {
    final List<dynamic> decodedResponse = jsonDecode(response.body);

    final List<TransactionModel> transactions = [];

    for (Map<String, dynamic> transactionMap in decodedResponse) {
      final Map<String, dynamic> contactMap = transactionMap['contact'];

      final transaction = TransactionModel(
        value: transactionMap['value'],
        contact: ContactModel(
          id: 0,
          name: contactMap['name'],
          accountNumber: contactMap['accountNumber'],
        ),
      );

      transactions.add(transaction);
    }
    return transactions;
  }
}
