class GrpcCall {
  final Map<String, dynamic> request;
  final Map<String, dynamic> response;
  final String name;
  final String time;

  const GrpcCall({
    required this.request,
    required this.response,
    required this.name,
    required this.time,
  });

  factory GrpcCall.fromJson(Map<String, dynamic> json) {
    return GrpcCall(
      request: json['request'],
      response: json['response'],
      name: json['method'],
      time: json['time'],
    );
  }
}
