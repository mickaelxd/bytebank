
import 'package:http_interceptor/http_interceptor.dart';

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
