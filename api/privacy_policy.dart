import 'dart:convert';
import 'dart:io';

void main() {
  // Vercel serverless entry point
}

// Handler function for Vercel
Future<void> handler(HttpRequest request, HttpResponse response) async {
  // Enable CORS
  response.headers.add('Access-Control-Allow-Origin', '*');
  response.headers.add('Access-Control-Allow-Methods', 'GET, OPTIONS');
  response.headers.add('Content-Type', 'application/json');

  if (request.method == 'OPTIONS') {
    response.statusCode = 200;
    await response.close();
    return;
  }

  try {
    // Read privacy policy from file (must be in vercel.json files include)
    final file = File('assets/docs/privacy_policy.md');
    final content = await file.readAsString();

    response.statusCode = 200;
    response.write(
      jsonEncode({
        'content': content,
        'lastUpdated': DateTime.now().toIso8601String(),
      }),
    );
  } catch (e) {
    response.statusCode = 500;
    response.write(jsonEncode({'error': e.toString()}));
  }

  await response.close();
}
