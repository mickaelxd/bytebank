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
      final transactionJson = jsonEncode(transaction.toJson());

      final Response response = await client.post(
        Uri.parse('$baseUrl/transactions'),
        body: transactionJson,
        headers: {
          'Content-type': 'application/json',
          'password': '1000',
        },
      );

      Map<String, dynamic> transactionMap = jsonDecode(response.body);

      return TransactionModel.fromJson(transactionMap);
    } on Exception catch (e) {
      print(e);
      return null;
    }
  }

  List<TransactionModel> _toTransactions(Response response) {
    final List<dynamic> decodedJson = jsonDecode(response.body);

    final List<TransactionModel> transactions = [];

    for (Map<String, dynamic> transactionJson in decodedJson) {
      transactions.add(TransactionModel.fromJson(transactionJson));
    }
    return transactions;
  }
}
