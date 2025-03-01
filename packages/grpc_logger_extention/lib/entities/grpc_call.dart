import 'package:uuid/uuid.dart';

/// Represents a logged gRPC call with its request, response, name, and time.
class GrpcCall {
  ///@nodoc
  const GrpcCall({
    required this.id,
    required this.request,
    required this.response,
    required this.name,
    required this.time,
  });

  /// The unique identifier of the gRPC call.
  final String id;

  /// The request data of the gRPC call.
  final Map<String, dynamic> request;

  /// The response data of the gRPC call.
  final Map<String, dynamic> response;

  /// The name or method of the gRPC call.
  final String name;

  /// The timestamp when the gRPC call was logged.
  final String time;

  /// Attempts to create a `GrpcCall` from JSON data, returning null if data is invalid.
  static GrpcCall? tryFromJson(Map<String, dynamic> json) {
    if (json
        case {
          'request': final Map<String, dynamic> request,
          'response': final Map<String, dynamic> response,
          'method': final String method,
          'time': final String time,
        }) {
      return GrpcCall(
        request: request,
        response: response,
        name: method,
        time: time,
        id: const Uuid().v4(),
      );
    }
    return null;
  }

  /// Method to check if the gRPC call name matches the query
  bool matchesQuery(String query) =>
      name.toLowerCase().contains(query.toLowerCase());
}
