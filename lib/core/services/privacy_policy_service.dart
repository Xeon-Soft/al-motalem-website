/// Service for fetching privacy policy content from the API.
/// 
/// This service handles both development and production environments,
/// automatically detecting the appropriate base URL to use.
library;

import 'dart:convert';

import 'package:http/http.dart' as http;

/// Service class for privacy policy operations.
class PrivacyPolicyService {
  PrivacyPolicyService._(); // Private constructor to prevent instantiation

  /// Determines the base URL based on the current environment.
  /// 
  /// In production (Vercel), uses relative URLs.
  /// In development, uses localhost with configured port.
  static String get _baseUrl {
    const isProduction = bool.fromEnvironment(
      'dart.vm.product',
      defaultValue: false,
    );

    if (isProduction) {
      // Same origin on Vercel - no host needed
      return '';
    }

    // Development - use local server
    const apiPort = String.fromEnvironment('API_PORT', defaultValue: '5967');
    return 'http://localhost:$apiPort';
  }

  /// Fetches the privacy policy content from the API.
  /// 
  /// Returns the markdown content as a string.
  /// Throws an exception if the request fails.
  static Future<String> fetchPrivacyPolicy() async {
    final response = await http.get(
      Uri.parse('$_baseUrl/api/privacy-policy'),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      return data['content'] as String;
    } else {
      throw Exception('Failed to load privacy policy: ${response.statusCode}');
    }
  }
}
