import 'package:devtools_app_shared/ui.dart';
import 'package:flutter/material.dart';

/// GrpcView is a widget that displays a JSON response in a formatted manner.
class GrpcView extends StatefulWidget {
  ///@nodoc
  const GrpcView({required this.responseJson, required this.title, super.key});

  /// JSON response to be displayed.
  final Map<String, dynamic>? responseJson;

  /// Title of the view.
  final String title;

  @override
  State<GrpcView> createState() => _GrpcViewState();
}

class _GrpcViewState extends State<GrpcView> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: TwoDimensionalScrollable(
        horizontalDetails: const ScrollableDetails.horizontal(),
        verticalDetails: const ScrollableDetails.vertical(),
        viewportBuilder: (ctx, _, __) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(widget.title),
              const Divider(),
              SizedBox(
                width: MediaQuery.sizeOf(ctx).width / 3,
                child: FormattedJson(
                  json: widget.responseJson,
                  formattedString:
                      widget.responseJson == null ? 'Choose a gRPC call' : null,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
