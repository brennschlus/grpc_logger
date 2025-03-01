import 'package:flutter/material.dart';
import 'package:grpc_logger_extention/entities/grpc_call.dart';
import 'package:two_dimensional_scrollables/two_dimensional_scrollables.dart';

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
    return Padding(
      padding: const EdgeInsets.all(16),
      child: TableView.builder(
        columnCount: 2,
        rowCount: widget.grpcList.length,
        columnBuilder: (index) {
          return TableSpan(
            extent: index == 0
                ? const FixedTableSpanExtent(100)
                : const FixedTableSpanExtent(300),
          );
        },
        rowBuilder: (index) {
          return const TableSpan(
            extent: FixedTableSpanExtent(50),
          );
        },
        cellBuilder: (ctx, vicinity) {
          final grpcCall = widget.grpcList[vicinity.row];
          return TableViewCell(
            child: MaterialButton(
              onPressed: () => widget.onGrpcCallSelected(vicinity.row),
              child: Container(
                padding: const EdgeInsets.all(8),
                alignment: Alignment.centerLeft,
                child: Text(
                  vicinity.column == 0 ? grpcCall.time : grpcCall.name,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: grpcCall.id == widget.selectedCallId
                        ? Colors.deepOrangeAccent
                        : Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
