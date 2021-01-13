import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:nalij/models/article.dart';

class ArticleApi {
  static List<Article> parseArticles(String responseBody, authToken) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Article>((json) => Article.fromJson(json)).toList();
  }

  static Future<List<Article>> fetchArticles(authToken) async {
    print(authToken);
    final response = await http
        .get('https://us-central1-nalij-api.cloudfunctions.net/app/api/read',
              headers: {
                'auth-token': authToken,
              });
    if (response.statusCode == 200) {
      return parseArticles(response.body, authToken);
    } else {
      throw Exception('Unable to fetch products from the REST API');
    }
  }
}
