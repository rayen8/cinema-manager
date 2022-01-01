import 'package:cinema_app/interceptors/http_interceptor.dart';
import 'package:http_interceptor/http/http.dart';

/// The [InterceptedService] service that appends the `Bearer` token
/// to all incoming HTTP Requests.
///
/// Simply use the static getter instead of the default [http] package methods.
///
/// Example:
/// ```
/// InterceptedService.http.get(Uri.parse(url)).then(...
/// ```
abstract class InterceptedService {
  static final InterceptedHttp _interceptedHttp = InterceptedHttp.build(
    interceptors: [HttpInterceptor()],
  );
  static InterceptedHttp get http {
    return _interceptedHttp;
  }
}
