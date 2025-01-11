import 'package:flutter/foundation.dart';
import 'package:grpc_logger_extention/entities/grpc_call.dart';

class GrpcCallsController extends ChangeNotifier
    implements ValueListenable<List<GrpcCall>> {
  final List<GrpcCall> _grpcList;
  int? _selectedIndex;

  GrpcCallsController() : _grpcList = List.empty(growable: true);

  GrpcCall? get selectedGrpcCall =>
      _selectedIndex == null ? null : _grpcList[_selectedIndex!];

  void selectGrpcCall(int index) {
    _selectedIndex = index;
    super.notifyListeners();
  }

  bool get isNotEmpty => _grpcList.isNotEmpty;

  void addGrpcCall(GrpcCall grpcCall) {
    _grpcList.add(grpcCall);
    super.notifyListeners();
  }

  void clear() {
    _grpcList.clear();
    super.notifyListeners();
  }

  @override
  List<GrpcCall> get value => _grpcList;
}
