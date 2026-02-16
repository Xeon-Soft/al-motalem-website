// // lib/services/privacy_policy_service.dart
// import 'dart:convert';

// import 'package:http/http.dart' as http;

// class PrivacyPolicyService {
//   static const String _apiPort = String.fromEnvironment(
//     'API_PORT',
//     defaultValue: '5967',
//   );

//   static String get _baseUrl => 'http://localhost:$_apiPort';

//   // Use relative URL - works on any port!
//   static Future<String> fetchPrivacyPolicy() async {
//     final response = await http.get(
//       Uri.parse('/api/privacy-policy'), // No host:port needed
//     );

//     if (response.statusCode == 200) {
//       final data = jsonDecode(response.body);
//       return data['content'] as String;
//     } else {
//       throw Exception('Failed to load: ${response.statusCode}');
//     }
//   }

//   // Fallback to local asset if server fails
//   static Future<String> fetchWithFallback() async {
//     try {
//       return await fetchPrivacyPolicy();
//     } catch (e) {
//       // In production, you might want to return a cached version
//       throw Exception('Could not load privacy policy: $e');
//     }
//   }
// }

import 'dart:convert';

import 'package:http/http.dart' as http;

class PrivacyPolicyService {
  // Auto-detect environment
  static String get _baseUrl {
    // Check if running on Vercel production
    const isProduction = bool.fromEnvironment(
      'dart.vm.product',
      defaultValue: false,
    );

    if (isProduction) {
      // Same origin on Vercel
      return '';
    }

    // Development - use local server
    const apiPort = String.fromEnvironment('API_PORT', defaultValue: '5967');
    return 'http://localhost:$apiPort';
  }

  static Future<String> fetchPrivacyPolicy() async {
    final response = await http.get(Uri.parse('$_baseUrl/api/privacy-policy'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['content'] as String;
    } else {
      throw Exception('Failed to load: ${response.statusCode}');
    }
  }
}
