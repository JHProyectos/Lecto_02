//lib/src/data/datasources/remote/api_source.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../core/config/app_config.dart';

class ApiSource {
  final String baseUrl = AppConfig.apiBaseUrl;
  final http.Client _client = http.Client();
  final String authToken = 'your_google_api_token'; // Token de autenticación (dinámico en producción).

  Future<Map<String, dynamic>> get(String endpoint, {Map<String, String>? params}) async {
    try {
      final uri = Uri.parse('$baseUrl/$endpoint').replace(queryParameters: params);
      final response = await _client
          .get(uri, headers: _headers())
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        final errorMessage = json.decode(response.body)['error'] ?? 'Unknown error';
        throw Exception('Failed to load data: ${response.statusCode} - $errorMessage');
      }
    } catch (e) {
      throw Exception('Error in GET request: $e');
    }
  }

  Future<Map<String, dynamic>> post(String endpoint, Map<String, dynamic> body) async {
    try {
      final response = await _client
          .post(
            Uri.parse('$baseUrl/$endpoint'),
            headers: _headers(),
            body: json.encode(body),
          )
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200 || response.statusCode == 201) {
        return json.decode(response.body);
      } else {
        final errorMessage = json.decode(response.body)['error'] ?? 'Unknown error';
        throw Exception('Failed to post data: ${response.statusCode} - $errorMessage');
      }
    } catch (e) {
      throw Exception('Error in POST request: $e');
    }
  }

  Map<String, String> _headers() {
    return {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $authToken',
    };
  }

  void close() {
    _client.close();
  }
}
