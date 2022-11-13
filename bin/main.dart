import 'dart:io';

import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;

/// This is the starting point for your Serverpod server. Typically, there is
/// no need to modify this file.
void main() async {
  var handler =
      const Pipeline().addMiddleware(logRequests()).addHandler(_echoRequest);
  var server = await shelf_io.serve(handler, 'localhost', 8080);
// Enable content compression
  server.autoCompress = true;
  print('Serving at http://${server.address.host}:${server.port}');
}

Future<Response> _echoRequest(Request request) async {
  final result =
      await File('${Directory.current.path}/public/index.html').readAsString();
  return Response.ok(result, headers: {'content-type': 'text/html'});
}
