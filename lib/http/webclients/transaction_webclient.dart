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

  Future<TransactionModel> save(
    TransactionModel transaction,
    String password,
  ) async {
    final transactionJson = jsonEncode(transaction.toJson());

    final Response response = await client.post(
      Uri.parse('$baseUrl/transactions'),
      body: transactionJson,
      headers: {
        'Content-type': 'application/json',
        'password': password,
      },
    );

    switch (response.statusCode) {
      case 200:
        return TransactionModel.fromJson(jsonDecode(response.body));
      case 400:
        throw Exception('There was an error submitting transaction');
      case 403:
        throw Exception('Authentication failed!');
      case 500:
        throw Exception('Unknown Error');
      default:
        throw Exception('Unknown Error');
    }
  }
}
