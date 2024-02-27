import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = "http://lms.muepetro.com/api/UserController1";

  
  static Future<List<dynamic>> fetchData(String endpoint) async {
    final response = await http.get(Uri.parse('$baseUrl/$endpoint'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load data: ${response.statusCode}');
    }
  }

  static Future postData(String endpoint, Map data) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/$endpoint'),
        body: data,
      );

      if (response.statusCode == 200) {
        if (response.body.isNotEmpty) {
          return json.decode(response.body);
        } else {
          throw Exception('Response body is empty');
        }
      } else {
        throw Exception('Failed to post data: ${response.statusCode}');
      }
    } on SocketException catch (e) {
      throw Exception('Failed to connect: $e');
    } on HttpException catch (e) {
      throw Exception('Failed to connect: $e');
    } catch (e) {
      throw Exception('Failed to post data: $e');
    }
  }
}


