import 'dart:developer';

import 'package:cinema_app/services/auth/auth_strategy.dart';
import 'package:http_interceptor/http/http.dart';
import 'package:http_interceptor/models/response_data.dart';
import 'package:http_interceptor/models/request_data.dart';

class HttpInterceptor implements InterceptorContract {
  final AuthStrategy _authStrategy = AuthStrategy();

  @override
  Future<RequestData> interceptRequest({required RequestData data}) async {
    String? token = await _authStrategy.getToken();
    if (token == null) log("Interceptor got a null token!");
    data.headers['authorization'] = "Bearer $token";
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({required ResponseData data}) async {
    return data;
  }
}
