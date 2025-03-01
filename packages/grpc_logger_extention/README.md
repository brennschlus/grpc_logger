# gRPC Logger Extension

A Dart DevTools extension for visualizing gRPC calls in Flutter applications.

## Overview

This extension is part of the `grpc_logger` project and provides a user-friendly interface in Dart DevTools to visualize and inspect gRPC calls made by your application.

## Features

- **View gRPC Calls**: Display logged gRPC calls in a clean, organized list
- **Inspect Request/Response Data**: View detailed request and response payloads
- **Search Functionality**: Filter logged calls to find specific methods
- **Real-time Updates**: See new gRPC calls as they occur in your application

## Implementation Details

The extension consists of:

1. **Controller Layer**:
   - `GrpcCallsController`: Manages the list of gRPC calls and provides methods for selection, filtering, and data management

2. **Entity Layer**:
   - `GrpcCall`: Represents a gRPC call with its request, response, method name, and timestamp

3. **UI Components**:
   - Main body layout with split-pane UI
   - List view for gRPC calls
   - Detailed views for request and response payloads
   - Search functionality for filtering calls

## Getting Started

To use this extension:

1. Make sure you have the `grpc_logger` package added to your application
2. Configure your gRPC clients with the logger interceptor
3. Run your application with DevTools
4. Navigate to the "gRPC Logger" extension in DevTools to see your logged calls
