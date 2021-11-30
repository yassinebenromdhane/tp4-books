import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart';
import '../models/book.dart';

class HttpHelper {
  final String authority = 'www.googleapis.com';
  final String path = '/books/v1/volumes';

  Map<String, dynamic> params = {'q': 'flutter dart', 'maxResults': '40',};

  Future<List<Book>> getBooks(String query) async {
    Uri uri = Uri.https(authority, path, params);
    Response result = await http.get(uri);
    if (result.statusCode == 200) {
      print('Success');
      final jsonResponse = json.decode(result.body);
      final booksMap = jsonResponse['items'];
      List<Book> books = booksMap.map<Book>((i) =>
          Book.fromJson(i)).toList();
      return books;
    } else {
      print('Failed');
      return [];
    }
  }
}