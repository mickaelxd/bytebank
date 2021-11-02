import 'dart:convert';

import 'package:bytebank/models/contact_model.dart';
import 'package:bytebank/models/transaction_model.dart';
import 'package:http/http.dart';
import 'package:http_interceptor/http_interceptor.dart';

const baseUrl = 'http://192.168.0.126:8080';

class LoggingInterceptor implements InterceptorContract {
  @override
  Future<RequestData> interceptRequest({required RequestData data}) async {
    print('======= REQUEST BEGIN =========');
    print('baseUrl ${data.baseUrl}');
    print('body ${data.body}');
    print('headers ${data.headers}');
    print('======= REQUEST END =========');
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({required ResponseData data}) async {
    print('======= RESPONSE BEGIN =========');
    print('statusCode ${data.statusCode}');
    print('body ${data.body}');
    print('headers ${data.headers}');
    print('======= RESPONSE END =========');
    return data;
  }
}

Future<List<TransactionModel>> findAll() async {
  try {
    Client client = InterceptedClient.build(
      interceptors: [LoggingInterceptor()],
    );

    final Response response = await client
        .get(Uri.parse('$baseUrl/transactions'))
        .timeout(Duration(seconds: 15));

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
  } on Exception catch (e) {
    print(e);
    return [];
  }
}
