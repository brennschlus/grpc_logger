import 'package:grpc_logger_extention/controllers/grpc_calls_controller.dart';
import 'package:grpc_logger_extention/entities/grpc_call.dart';
import 'package:test/test.dart';

void main() {
  group('GrpcCallsController', () {
    late GrpcCallsController controller;

    setUp(() {
      controller = GrpcCallsController();
    });

    test('initial state is empty', () {
      expect(controller.isNotEmpty, false);
      expect(controller.value.isEmpty, true);
    });

    test('addGrpcCall adds a call and notifies listeners', () {
      final grpcCall = GrpcCall(
        request: {'key': 'value'},
        response: {'result': 'success'},
        name: 'testMethod',
        time: DateTime.now().toIso8601String(),
      );
      controller.addGrpcCall(grpcCall);

      expect(controller.isNotEmpty, true);
      expect(controller.value.length, 1);
      expect(controller.value.first, grpcCall);
    });

    test('addGrpcCall with null does not add and notifies listeners', () {
      controller.addGrpcCall(null);

      expect(controller.isNotEmpty, false);
      expect(controller.value.isEmpty, true);
    });

    test('clear removes all calls and notifies listeners', () {
      final grpcCall = GrpcCall(
        request: {'key': 'value'},
        response: {'result': 'success'},
        name: 'testMethod',
        time: DateTime.now().toIso8601String(),
      );
      controller
        ..addGrpcCall(grpcCall)
        ..clear();

      expect(controller.isNotEmpty, false);
      expect(controller.value.isEmpty, true);
    });

    test('selectGrpcCall selects a call and notifies listeners', () {
      final grpcCall = GrpcCall(
        request: {'key': 'value'},
        response: {'result': 'success'},
        name: 'testMethod',
        time: DateTime.now().toIso8601String(),
      );
      controller
        ..addGrpcCall(grpcCall)
        ..selectGrpcCall(0);

      expect(controller.selectedGrpcCall, grpcCall);
    });

    test(
        'selectGrpcCall with invalid index does not select and notifies listeners',
        () {
      controller.selectGrpcCall(-1);

      expect(controller.selectedGrpcCall, null);
    });

    test('search filters calls based on query', () {
      final call1 = GrpcCall(
        request: {'key': 'value'},
        response: {'result': 'success'},
        name: 'testMethod',
        time: DateTime.now().toIso8601String(),
      );
      final call2 = GrpcCall(
        request: {'key': 'value'},
        response: {'result': 'failure'},
        name: 'anotherMethod',
        time: DateTime.now().toIso8601String(),
      );
      controller
        ..addGrpcCall(call1)
        ..addGrpcCall(call2)
        ..search('test');

      expect(controller.value.length, 1);
      expect(controller.value.first, call1);
    });

    test('search with empty query returns all calls', () {
      final call1 = GrpcCall(
        request: {'key': 'value'},
        response: {'result': 'success'},
        name: 'testMethod',
        time: DateTime.now().toIso8601String(),
      );
      final call2 = GrpcCall(
        request: {'key': 'value'},
        response: {'result': 'failure'},
        name: 'anotherMethod',
        time: DateTime.now().toIso8601String(),
      );
      controller
        ..addGrpcCall(call1)
        ..addGrpcCall(call2)
        ..search('');

      expect(controller.value.length, 2);
    });
  });
}
