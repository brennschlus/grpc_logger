import 'dart:math' show max;

import 'package:devtools_app_shared/ui.dart';
import 'package:flutter/material.dart';
import 'package:grpc_logger_extention/entities/grpc_call.dart';

/// RpcList is a widget that displays a list of gRPC calls.
class RpcList extends StatefulWidget {
  ///@nodoc
  const RpcList({
    required this.grpcList,
    required this.onGrpcCallSelected,
    this.selectedCallId,
    super.key,
  });

  /// The list of gRPC calls to display.
  final List<GrpcCall> grpcList;

  /// The callback function to be called when a gRPC call is selected.
  final ValueChanged<int> onGrpcCallSelected;

  /// The ID of the currently selected gRPC call.
  final String? selectedCallId;

  @override
  State<RpcList> createState() => _RpcListState();
}

class _RpcListState extends State<RpcList> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AreaPaneHeader(
          title: Text('GRPC Calls', style: theme.regularTextStyle),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: SizedBox(
              width: max(400, MediaQuery.sizeOf(context).width - 40),
              child: ListView.builder(
                itemCount: widget.grpcList.length,
                itemBuilder: (context, index) {
                  final grpcCall = widget.grpcList[index];
                  final isSelected = grpcCall.id == widget.selectedCallId;

                  return Material(
                    color:
                        isSelected ? theme.highlightColor : Colors.transparent,
                    child: InkWell(
                      onTap: () => widget.onGrpcCallSelected(index),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 12,
                        ),
                        child: Row(
                          children: [
                            Text(
                              grpcCall.time,
                              style: TextStyle(
                                color: isSelected
                                    ? theme.colorScheme.primary
                                    : null,
                                fontWeight: isSelected ? FontWeight.bold : null,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                grpcCall.name,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: isSelected
                                      ? theme.colorScheme.primary
                                      : null,
                                  fontWeight:
                                      isSelected ? FontWeight.bold : null,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
