import 'dart:convert';

import 'package:bytebank/models/contact_model.dart';
import 'package:bytebank/models/transaction_model.dart';
import 'package:http/http.dart';
import 'package:http_interceptor/http_interceptor.dart';

const baseUrl = 'http://192.168.0.126:8080';

Client client = InterceptedClient.build(
  interceptors: [LoggingInterceptor()],
);

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

Future<TransactionModel?> save(TransactionModel transaction) async {
  try {
    final Map<String, dynamic> transactionMap = {
      'value': transaction.value,
      'contact': {
        'name': transaction.contact.name,
        'accountNumber': transaction.contact.accountNumber,
      },
    };

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
