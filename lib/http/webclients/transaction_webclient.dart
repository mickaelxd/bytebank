import 'dart:convert';
import 'dart:io';

import 'package:bytebank/http/webclient.dart';
import 'package:bytebank/models/transaction_model.dart';
import 'package:http/http.dart';

class TransactionWebClient {
  Future<List<TransactionModel>> findAll() async {
    try {
      final Response response = await client.get(
        Uri.parse('$baseUrl/transactions'),
      );

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

    if (response.statusCode != 200) {
      throw HttpException(
        statusCodeResponses[response.statusCode] ?? 'Unknown Error',
      );
    }

    return TransactionModel.fromJson(jsonDecode(response.body));
  }

  Map<int, String> statusCodeResponses = {
    400: 'There was an error submitting transaction',
    401: 'Authentication failed',
  };
}
