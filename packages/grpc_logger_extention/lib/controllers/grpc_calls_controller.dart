import 'package:flutter/foundation.dart';
import 'package:grpc_logger_extention/entities/grpc_call.dart';

/// Manages a list of gRPC calls, notifying listeners of changes.
///
/// This controller implements `ValueListenable` to allow widgets to listen
/// for changes in the list of gRPC calls.
class GrpcCallsController extends ChangeNotifier
    implements ValueListenable<List<GrpcCall>> {
  ///@nodoc
  GrpcCallsController() : _grpcList = List.empty(growable: true);

  /// Internal list to store gRPC calls.
  final List<GrpcCall> _grpcList;

  /// Index of the currently selected gRPC call, if any.
  int? _selectedIndex;

  /// Returns the currently selected gRPC call, or null if none is selected.
  GrpcCall? get selectedGrpcCall =>
      _selectedIndex == null ? null : _grpcList[_selectedIndex!];

  /// Selects a gRPC call by its index, notifying listeners of the change.
  void selectGrpcCall(int index) {
    _selectedIndex = index;
    super.notifyListeners();
  }

  /// Checks if the list of gRPC calls is not empty.
  bool get isNotEmpty => _grpcList.isNotEmpty;

  /// Adds a new gRPC call to the list, notifying listeners if successful.
  void addGrpcCall(GrpcCall? grpcCall) {
    if (grpcCall != null) {
      _grpcList.add(grpcCall);
      super.notifyListeners();
    }
  }

  /// Clears all gRPC calls from the list, notifying listeners.
  void clear() {
    _grpcList.clear();
    super.notifyListeners();
  }

  @override
  List<GrpcCall> get value => _grpcList;
}
