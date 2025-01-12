import 'dart:developer' as developer;

import 'package:grpc/service_api.dart';
import 'package:protobuf/protobuf.dart';

/// gRPC call logger that bypasses logging for filtered methods.
///
/// Logs details of unary calls unless they're in `filteredCalls`.
class LoggerInterceptor extends ClientInterceptor {
  ///@nodoc
  LoggerInterceptor({this.filteredCalls});

  /// List of methods for which logging should be skipped.
  final Set<ClientMethod<dynamic, dynamic>>? filteredCalls;

  @override
  ResponseFuture<R> interceptUnary<Q, R>(
    ClientMethod<Q, R> method,
    Q request,
    CallOptions options,
    ClientUnaryInvoker<Q, R> invoker,
  ) {
    if (filteredCalls != null && filteredCalls!.contains(method)) {
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
