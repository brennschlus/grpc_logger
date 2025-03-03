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

  // Filtered from search query grpc calls list.
  List<GrpcCall> _filteredGrpcCallsList = List.empty();

  /// Index of the currently selected gRPC call, if any.
  int? _selectedIndex;

  /// Indicates whether the controller is currently in search mode.
  bool _isSearching = false;

  /// Returns the currently selected gRPC call, or null if none is selected.
  GrpcCall? get selectedGrpcCall =>
      _selectedIndex == null ? null : _grpcList[_selectedIndex!];

  /// Selects a gRPC call by its index, notifying listeners of the change.
  void selectGrpcCall(int index) {
    if (index < 0 || index > _grpcList.length - 1) return;
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

  /// Searches through the list of gRPC calls based on a query.
  void search(String query) {
    if (query.trim().isEmpty) {
      _filteredGrpcCallsList = List.empty();
      _isSearching = false;
      super.notifyListeners();
      return;
    }

    _filteredGrpcCallsList =
        List.from(_grpcList.where((call) => call.matchesQuery(query)));

    _isSearching = true;
    super.notifyListeners();
    print(_filteredGrpcCallsList.length);
  }

  @override
  List<GrpcCall> get value => _isSearching ? _filteredGrpcCallsList : _grpcList;
}
