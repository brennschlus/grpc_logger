import 'dart:async';

import 'package:devtools_app_shared/ui.dart';
import 'package:devtools_extensions/devtools_extensions.dart';
import 'package:flutter/material.dart';
import 'package:grpc_logger_extention/controllers/grpc_calls_controller.dart';
import 'package:grpc_logger_extention/entities/grpc_call.dart';
import 'package:grpc_logger_extention/widgets/gprc_view.dart';
import 'package:grpc_logger_extention/widgets/rpc_list.dart';
import 'package:uuid/uuid.dart';

/// A widget that displays a UI for managing and viewing logged gRPC calls within DevTools.
///
/// This widget uses a [GrpcCallsController] to handle the state of gRPC calls,
/// providing functionality to clear, search, select, and display details of calls.
class GRPCLoggerDevToolsExtensionBody extends StatefulWidget {
  ///@nodoc
  const GRPCLoggerDevToolsExtensionBody({
    required this.grpcCallsController,
    super.key,
  });

  /// The controller managing the list of gRPC calls.
  final GrpcCallsController grpcCallsController;

  @override
  State<GRPCLoggerDevToolsExtensionBody> createState() =>
      _GRPCLoggerDevToolsExtensionBodyState();
}

class _GRPCLoggerDevToolsExtensionBodyState
    extends State<GRPCLoggerDevToolsExtensionBody> {
  /// A TextEditingController holding the text input from the search field
  final _searchController = TextEditingController();

  /// The debounce time period in milliseconds (500ms = 0.5 seconds)
  final _debounceTime = 500;

  /// Debounce timer for searching
  Timer? _debounce;

  /// Search listener function that cancels any existing debounced task
  /// and schedules a new search after debounceTime expires
  void searchListener() {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(Duration(milliseconds: _debounceTime), () {
      widget.grpcCallsController.search(_searchController.text);
    });
  }

  @override
  void initState() {
    super.initState();

    _searchController.addListener(searchListener);

    serviceManager.onServiceAvailable.then(
      (service) => service.onExtensionEvent.listen((event) {
        if (event.extensionKind == 'grpc_logger:interceptor_unary_call' &&
            event.extensionData != null) {
          widget.grpcCallsController
              .addGrpcCall(GrpcCall.tryFromJson(event.extensionData!.data));
        }
      }),
    );
  }

  @override
  void dispose() {
    _searchController.removeListener(searchListener);
    _debounce?.cancel();
    super.dispose();
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
            const SizedBox(width: 16),
            Flexible(
              child: DevToolsClearableTextField(
                  hintText: 'Search',
                  prefixIcon: const Icon(Icons.search_outlined),
                  controller: _searchController),
            ),
          ],
        ),
        const SizedBox(height: 16),
        ValueListenableBuilder(
          valueListenable: widget.grpcCallsController,
          builder: (_, grpcList, __) {
            return Expanded(
              child: SplitPane(
                axis: Axis.horizontal,
                initialFractions: const [1 / 3, 1 / 3, 1 / 3],
                children: [
                  RoundedOutlinedBorder(
                    child: RpcList(
                      grpcList: grpcList,
                      onGrpcCallSelected:
                          widget.grpcCallsController.selectGrpcCall,
                      selectedCallId:
                          widget.grpcCallsController.selectedGrpcCall?.id,
                    ),
                  ),
                  RoundedOutlinedBorder(
                    child: GrpcView(
                      responseJson:
                          widget.grpcCallsController.selectedGrpcCall?.request,
                      title: 'Request',
                    ),
                  ),
                  RoundedOutlinedBorder(
                    child: GrpcView(
                      responseJson:
                          widget.grpcCallsController.selectedGrpcCall?.response,
                      title: 'Response',
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
