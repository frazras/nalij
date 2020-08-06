import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:nalij/models/article.dart';

class ArticleApi {

  static List<Article> parseArticles(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Article>((json) =>Article.fromJson(json)).toList();
  }

  static Future<List<Article>> fetchArticles() async {
    final response = await http.get('https://us-central1-nalij-api.cloudfunctions.net/app/api/read');
    if (response.statusCode == 200) {
      return parseArticles(response.body);
    } else {
      throw Exception('Unable to fetch products from the REST API');
    }
  }
}
