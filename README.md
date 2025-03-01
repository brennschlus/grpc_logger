# grpc_logger

A Dart package and DevTools extension for logging and visualizing gRPC calls.

## Overview

This project provides tools to enhance the development experience for gRPC-based applications in Dart:

- **`grpc_logger`**: A Dart package that includes a gRPC interceptor to log unary gRPC calls and post events to Dart DevTools.
- **`grpc_logger_extention`**: A Dart DevTools extension that visualizes the logged gRPC calls in a user-friendly interface.

Together, these components allow developers to integrate gRPC call logging into their applications and inspect the logs within DevTools.

## Features

- **Log gRPC Calls**: Capture details of unary gRPC calls, including request, response, method name, and timestamp.
- **Filterable Logging**: Optionally exclude specific methods from being logged.
- **Visualization in DevTools**: View logged calls with a searchable list and detailed request/response views.

## Getting Started

### Using the Logger in Your Application

1. **Add the `grpc_logger` Package**
   Include the `grpc_logger` package in your application's `pubspec.yaml`:

   ```yaml
   dependencies:
     grpc_logger: ^0.0.1
     ```
2. **Configure the Interceptor**
Import and add the LoggerInterceptor to your gRPC client:

```dart
import 'package:grpc_logger/logger_interceptor.dart';

final interceptor = LoggerInterceptor();
final channel = ClientChannel(
  'localhost',
  port: 50051,
  options: ChannelOptions(
    credentials: ChannelCredentials.insecure(),
    interceptors: [interceptor],
  ),
);
```
Optionally, filter out specific methods:
```dart
final filteredMethods = {YourServiceClient.yourMethod};
final interceptor = LoggerInterceptor(filteredCalls: filteredMethods);
````

### Using the DevTools Extension

1. **Ensure DevTools is Installed**
   Make sure you have Dart DevTools set up in your development environment. See Flutter DevTools documentation for setup instructions.

2. **Install the Extension**
   Install the `grpc_logger_extention` extension in your Dart DevTools.

3. **Start DevTools**
   Start Dart DevTools and navigate to the `grpc_logger_extention` extension.

### Development

To contribute to the development of `grpc_logger_extention`, follow these steps:

1. **Clone the Repository**
   Clone the repository from GitHub:

   ```bash
   git clone https://github.com/yourusername/grpc_logger_extention.git
   cd grpc_logger_extention
   ```

2. **Install Dependencies**
   Install the necessary dependencies:

   ```bash
   flutter pub get
   ```

3. **Run the Extension**
   Run the extension in development mode:

   ```bash
   flutter run -d chrome
   ```

4. **Test the Extension**
   Test the extension by using it in your application and verifying its functionality.

5. **Submit Pull Requests**
   Once you've made changes, submit a pull request to the main repository.
