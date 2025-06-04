import 'package:devtools_extensions/devtools_extensions.dart';
import 'package:flutter/material.dart';
import 'package:grpc_logger_extention/controllers/grpc_calls_controller.dart';
import 'package:grpc_logger_extention/widgets/body.dart';

void main() {
  runApp(const GRPCLoggerDevToolsExtension());
}

///@nodoc
class GRPCLoggerDevToolsExtension extends StatefulWidget {
  ///@nodoc
  const GRPCLoggerDevToolsExtension({super.key});

  @override
  State<GRPCLoggerDevToolsExtension> createState() =>
      _GRPCLoggerDevToolsExtensionState();
}

class _GRPCLoggerDevToolsExtensionState
    extends State<GRPCLoggerDevToolsExtension> {
  final GrpcCallsController grpcCallsController = GrpcCallsController();

  @override
  void dispose() {
    grpcCallsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DevToolsExtension(
      child: GRPCLoggerDevToolsExtensionBody(
        grpcCallsController: grpcCallsController,
      ),
    );
  }
}
