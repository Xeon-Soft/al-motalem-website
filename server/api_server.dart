// server/api_server.dart
// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:io';

import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as io;
import 'package:shelf_router/shelf_router.dart';
import 'package:shelf_static/shelf_static.dart';

class UnifiedServer {
  final int port;
  HttpServer? _server;

  UnifiedServer({this.port = 5967});

  Future<void> start() async {
    final router = _createRouter();

    final handler = const Pipeline()
        .addMiddleware(_corsMiddleware())
        .addMiddleware(logRequests())
        .addHandler(router.call);

    try {
      _server = await io.serve(handler, 'localhost', port);
      print('✅ Server running on http://localhost:${_server!.port}');
      print('🌐 Flutter app: http://localhost:${_server!.port}/');
      print('🔌 API: http://localhost:${_server!.port}/api/');
    } on SocketException catch (e) {
      if (e.osError?.errorCode == 48 || e.osError?.errorCode == 10048) {
        print('❌ Port $port in use');
        exit(1);
      }
      rethrow;
    }
  }

  Router _createRouter() {
    final router = Router();

    // API Routes - MUST come before static handler
    router.get('/api/health', (Request req) {
      return Response.ok(
        jsonEncode({'status': 'ok', 'server': 'dart'}),
        headers: {'content-type': 'application/json'},
      );
    });

    router.get('/api/privacy-policy', (Request req) async {
      try {
        final file = File('assets/docs/en.md');
        if (await file.exists()) {
          final content = await file.readAsString();
          return Response.ok(
            jsonEncode({'content': content}),
            headers: {'content-type': 'application/json'},
          );
        }
        return Response.notFound(
          jsonEncode({'error': 'Not found'}),
          headers: {'content-type': 'application/json'},
        );
      } catch (e) {
        return Response.internalServerError(
          body: jsonEncode({'error': e.toString()}),
          headers: {'content-type': 'application/json'},
        );
      }
    });

    // Serve Flutter build/web folder
    // In development: proxy to flutter run
    // In production: serve static files
    final flutterHandler = _createFlutterHandler();
    router.get('/<path|.*>', flutterHandler);

    return router;
  }

  Handler _createFlutterHandler() {
    // Check if build/web exists (production build)
    final buildDir = Directory('build/web');

    if (buildDir.existsSync()) {
      // Serve static files
      final staticHandler = createStaticHandler(
        'build/web',
        defaultDocument: 'index.html',
      );

      return (Request request) async {
        // Try static file first
        final response = await staticHandler(request);
        if (response.statusCode != 404) {
          return response;
        }
        // Fallback to index.html for SPA routing
        return staticHandler(request.change(path: 'index.html'));
      };
    } else {
      // Development mode - return placeholder
      return (Request request) {
        return Response.ok(
          '''
          <!DOCTYPE html>
          <html>
          <head>
            <title>Development Mode</title>
            <style>
              body { font-family: Arial, sans-serif; padding: 40px; }
              .box { background: #f0f0f0; padding: 20px; border-radius: 8px; }
              code { background: #e0e0e0; padding: 2px 6px; border-radius: 4px; }
            </style>
          </head>
          <body>
            <div class="box">
              <h1>🚀 Server is running!</h1>
              <p>API endpoints:</p>
              <ul>
                <li><code>GET /api/health</code></li>
                <li><code>GET /api/privacy-policy</code></li>
              </ul>
              <p>Flutter app not built yet. Run:</p>
              <code>flutter build web</code>
              <p>Then refresh this page.</p>
            </div>
          </body>
          </html>
        ''',
          headers: {'content-type': 'text/html'},
        );
      };
    }
  }

  Middleware _corsMiddleware() {
    return createMiddleware(
      requestHandler: (Request request) {
        if (request.method == 'OPTIONS') {
          return Response.ok(
            '',
            headers: {
              'Access-Control-Allow-Origin': '*',
              'Access-Control-Allow-Methods': 'GET, POST, OPTIONS',
              'Access-Control-Allow-Headers': '*',
            },
          );
        }
        return null;
      },
      responseHandler: (Response response) =>
          response.change(headers: {'Access-Control-Allow-Origin': '*'}),
    );
  }

  Future<void> stop() async {
    await _server?.close();
    print('👋 Server stopped');
  }
}
