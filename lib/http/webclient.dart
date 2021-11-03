import 'package:bytebank/http/interceptors/logging_interceptor.dart';
import 'package:http/http.dart';
import 'package:http_interceptor/http_interceptor.dart';

const baseUrl = 'http://192.168.0.126:8080';

Client client = InterceptedClient.build(
  interceptors: [LoggingInterceptor()],
);
