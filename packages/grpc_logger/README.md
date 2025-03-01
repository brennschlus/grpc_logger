# gRPC Logger

A simple Dart package that provides a gRPC client interceptor for logging request and response details.

## Features

- Log details of gRPC unary calls
- Filter specific methods to bypass logging
- Log output includes method path, request payload, response payload, and timestamp

## Installation

Add this package to your `pubspec.yaml`:

```yaml
dependencies:
  grpc_logger: ^1.0.0
```

Then run:

```
flutter pub get
```

## Usage

```dart
import 'package:grpc/grpc.dart';
import 'package:grpc_logger/logger_interceptor.dart';

void main() {
  // Create a set of methods to filter (optional)
  final filteredCalls = <ClientMethod>{};

  // Create the logger interceptor
  final loggerInterceptor = LoggerInterceptor(filteredCalls: filteredCalls);

  // Add to gRPC client channel options
  final channel = ClientChannel(
    'your-server.com',
    port: 443,
    options: ChannelOptions(
      credentials: ChannelCredentials.secure(),
      interceptors: [loggerInterceptor],
    ),
  );

  // Create your gRPC client with the channel
  final client = YourServiceClient(channel);

  // Make calls normally - they will be logged automatically
}
```

## Additional Information

This package only supports logging for unary calls. Stream-based gRPC methods are not currently supported.
