class GrpcTimeAndName {
  final String time;
  final String name;

  const GrpcTimeAndName({required this.time, required this.name});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GrpcTimeAndName &&
          runtimeType == other.runtimeType &&
          time == other.time &&
          name == other.name;

  @override
  int get hashCode => time.hashCode ^ name.hashCode;
}
