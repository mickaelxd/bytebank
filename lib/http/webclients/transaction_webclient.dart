import 'dart:convert';

import 'package:bytebank/http/webclient.dart';
import 'package:bytebank/models/transaction_model.dart';
import 'package:http/http.dart';

class TransactionWebClient {
  Future<List<TransactionModel>> findAll() async {
    try {
      final Response response = await client
          .get(Uri.parse('$baseUrl/transactions'))
          .timeout(Duration(seconds: 15));

      final List<dynamic> transactionsJson = jsonDecode(response.body);

      List<TransactionModel> transactions = transactionsJson.map((transaction) {
        return TransactionModel.fromJson(transaction);
      }).toList();

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
}
