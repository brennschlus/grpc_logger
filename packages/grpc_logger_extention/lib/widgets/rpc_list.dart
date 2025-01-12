import 'package:flutter/material.dart';
import 'package:grpc_logger_extention/entities/grpc_call.dart';

class RpcList extends StatefulWidget {
  final List<GrpcCall> grpcList;
  final ValueChanged<int> onGrpcCallSelected;
  const RpcList({
    required this.grpcList,
    required this.onGrpcCallSelected,
    super.key,
  });

  @override
  State<RpcList> createState() => _RpcListState();
}

class _RpcListState extends State<RpcList> {
  late ScrollController _scrollControllerY;
  late ScrollController _scrollControllerX;

  @override
  void initState() {
    _scrollControllerX = ScrollController();
    _scrollControllerY = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    _scrollControllerX.dispose();
    _scrollControllerY.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Scrollbar(
        scrollbarOrientation: ScrollbarOrientation.bottom,
        controller: _scrollControllerX,
        interactive: true,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          controller: _scrollControllerX,
          child: Scrollbar(
            controller: _scrollControllerY,
            child: SizedBox(
              width: MediaQuery.sizeOf(context).width,
              child: ListView.builder(
                controller: _scrollControllerY,
                itemBuilder: (_, index) => MaterialButton(
                  onPressed: () => widget.onGrpcCallSelected(index),
                  child: Row(
                    children: [
                      Text(widget.grpcList[index].time),
                      const SizedBox(width: 16),
                      Text(widget.grpcList[index].name),
                    ],
                  ),
                ),
                itemCount: widget.grpcList.length,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
