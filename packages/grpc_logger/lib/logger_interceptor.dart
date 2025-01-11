import 'package:grpc/service_api.dart';
import 'package:protobuf/protobuf.dart';
import 'dart:developer' as developer;

class LoggerInterceptor extends ClientInterceptor {
  final Set<ClientMethod> filteredCalls;

  LoggerInterceptor({filteredCalls})
      : filteredCalls = filteredCalls ?? const {};

  @override
  ResponseFuture<R> interceptUnary<Q, R>(
    ClientMethod<Q, R> method,
    Q request,
    CallOptions options,
    ClientUnaryInvoker<Q, R> invoker,
  ) {
    if (filteredCalls.contains(method)) {
      return invoker(method, request, options);
    }

    final response = invoker(method, request, options);

    final requestJson = (request as GeneratedMessage).toProto3Json();

    response.then((resp) {
      final dateNow = DateTime.now();

      final responseJson = (resp as GeneratedMessage).toProto3Json();
      final eventData = {
        'method': method.path,
        'request': requestJson,
        'response': responseJson,
        'time': '${dateNow.hour}:${dateNow.minute}:${dateNow.second}'
      };

      developer.postEvent('grpc_logger:interceptor_unary_call', eventData);
    });

    return response;
  }
}
