import 'package:devtools_app_shared/ui.dart';
import 'package:devtools_extensions/devtools_extensions.dart';
import 'package:flutter/material.dart';
import 'package:grpc_logger_extention/controllers/grpc_calls_controller.dart';
import 'package:grpc_logger_extention/entities/grpc_call.dart';
import 'package:grpc_logger_extention/widgets/gprc_view.dart';
import 'package:grpc_logger_extention/widgets/rpc_list.dart';

class GRPCLoggerDevToolsExtensionBody extends StatefulWidget {
  final GrpcCallsController grpcCallsController;
  const GRPCLoggerDevToolsExtensionBody(
      {super.key, required this.grpcCallsController});

  @override
  State<GRPCLoggerDevToolsExtensionBody> createState() =>
      _GRPCLoggerDevToolsExtensionBodyState();
}

class _GRPCLoggerDevToolsExtensionBodyState
    extends State<GRPCLoggerDevToolsExtensionBody> {
  @override
  void initState() {
    super.initState();

    serviceManager.onServiceAvailable.then(
      (service) => service.onExtensionEvent.listen((event) {
        if (event.extensionKind == 'grpc_logger:interceptor_unary_call' &&
            event.extensionData != null) {
          widget.grpcCallsController
              .addGrpcCall(GrpcCall.fromJson(event.extensionData!.data));
        }
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            DevToolsButton(
              onPressed: widget.grpcCallsController.clear,
              icon: Icons.block_outlined,
              label: 'Clear',
            ),
            SizedBox(width: 16),
            Flexible(
              child: DevToolsClearableTextField(
                hintText: 'Search',
                prefixIcon: Icon(Icons.search_outlined),
              ),
            ),
          ],
        ),
        SizedBox(height: 16),
        ValueListenableBuilder(
            valueListenable: widget.grpcCallsController,
            builder: (_, grpcList, __) {
              return Expanded(
                child: SplitPane(
                  axis: Axis.horizontal,
                  initialFractions: [1 / 3, 1 / 3, 1 / 3],
                  children: [
                    RoundedOutlinedBorder(
                      child: RpcList(
                        grpcList: grpcList,
                        onGrpcCallSelected:
                            widget.grpcCallsController.selectGrpcCall,
                      ),
                    ),
                    RoundedOutlinedBorder(
                      child: GrpcView(
                        responseJson: widget
                            .grpcCallsController.selectedGrpcCall?.request,
                        title: 'Request',
                      ),
                    ),
                    RoundedOutlinedBorder(
                      child: GrpcView(
                        responseJson: widget
                            .grpcCallsController.selectedGrpcCall?.response,
                        title: 'Response',
                      ),
                    ),
                  ],
                ),
              );
            }),
      ],
    );
  }
}
