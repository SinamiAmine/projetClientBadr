import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:projetbadr/models/Book.dart';
import 'package:projetbadr/models/api_response.dart';

class BookService {
  static const API = 'https://api.itbook.store/1.0/books/';
  static const Map<String, String> headers = {
    'accept': 'application/json',
    'Content-Type': 'application/json',
    'authorization': 'Basic c3R1ZHlkb3RlOnN0dWR5ZG90ZTEyMw=='
  };

  static Future<APIResponse<Book>> getBook(String id) {
    return http.get(Uri.parse(API + id), headers: headers).then((data) {
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);
        return APIResponse<Book>(data: Book.fromJson(jsonData));
      }
      return APIResponse<Book>(error: true, errorMessage: 'An error occured');
    }).catchError((_) =>
        APIResponse<Book>(error: true, errorMessage: 'An error occured'));
  }
}
