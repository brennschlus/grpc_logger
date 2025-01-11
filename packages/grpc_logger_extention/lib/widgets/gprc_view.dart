import 'package:devtools_app_shared/ui.dart';
import 'package:flutter/material.dart';

class GrpcView extends StatefulWidget {
  final Map<String, dynamic>? responseJson;
  final String title;
  const GrpcView({super.key, required this.responseJson, required this.title});

  @override
  State<GrpcView> createState() => _GrpcViewState();
}

class _GrpcViewState extends State<GrpcView> {
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
      padding: EdgeInsets.all(16),
      child: Scrollbar(
        scrollbarOrientation: ScrollbarOrientation.bottom,
        controller: _scrollControllerX,
        interactive: true,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          controller: _scrollControllerX,
          child: SingleChildScrollView(
            controller: _scrollControllerY,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(widget.title),
                Divider(),
                SizedBox(
                  width: MediaQuery.sizeOf(context).width / 3,
                  child: FormattedJson(
                    json: widget.responseJson,
                    formattedString: widget.responseJson == null
                        ? 'Choose a gRPC call'
                        : null,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
