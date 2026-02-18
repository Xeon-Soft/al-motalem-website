import 'dart:convert';
import 'dart:io';

/// Vercel serverless function handler for privacy policy API.
/// 
/// This function serves the privacy policy content from the assets/docs directory.
/// It supports CORS and returns JSON formatted content.
/// 
/// Endpoint: GET /api/privacy-policy
/// Response: {"content": "markdown content", "lastUpdated": "ISO timestamp"}
Future<void> handler(HttpRequest request, HttpResponse response) async {
  // Enable CORS headers
  response.headers.add('Access-Control-Allow-Origin', '*');
  response.headers.add('Access-Control-Allow-Methods', 'GET, OPTIONS');
  response.headers.add('Access-Control-Allow-Headers', 'Content-Type');
  response.headers.add('Content-Type', 'application/json');

  // Handle preflight requests
  if (request.method == 'OPTIONS') {
    response.statusCode = 200;
    await response.close();
    return;
  }

  // Only allow GET requests
  if (request.method != 'GET') {
    response.statusCode = 405;
    response.write(jsonEncode({
      'error': 'Method not allowed',
      'allowedMethods': ['GET'],
    }));
    await response.close();
    return;
  }

  try {
    // Read privacy policy from markdown file
    final file = File('assets/docs/en.md');
    
    if (!await file.exists()) {
      response.statusCode = 404;
      response.write(jsonEncode({
        'error': 'Privacy policy not found',
      }));
      await response.close();
      return;
    }

    final content = await file.readAsString();
    final lastModified = await file.lastModified();

    response.statusCode = 200;
    response.write(jsonEncode({
      'content': content,
      'lastUpdated': lastModified.toIso8601String(),
    }));
  } catch (e, stackTrace) {
    response.statusCode = 500;
    response.write(jsonEncode({
      'error': 'Internal server error',
      'message': e.toString(),
      'stackTrace': stackTrace.toString(),
    }));
  }

  await response.close();
}
