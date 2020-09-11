import 'dart:convert';
import 'package:flutter/foundation.dart';

List<Article> articleFromJson(String str) =>
    List<Article>.from(json.decode(str).map((x) => Article.fromJson(x)));

String articleToJson(List<Article> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Article {
  Article({
    @required this.id,
    @required this.title,
    this.author,
    @required this.source,
    @required this.duration,
    @required this.image,
    this.plays = 0,
    this.likes = 0,
    this.comments = 0,
    @required this.narrationUrl

  });


  final String id;
  final String title;
  final String author;
  final String source;
  final String duration;
  final String image;
  final int plays;
  final int likes;
  final int comments;
  final String narrationUrl;

  factory Article.fromJson(Map<String, dynamic> json) => Article(
        id: json["id"],
        title: json["title"],
        author: json["author"],
        source: json["source"],
        duration: json["duration"],
        plays: json["plays"],
        likes: json["likes"],
        image: json["image"],
        comments: json["comments"],
        narrationUrl: json["narration_url"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "author": author,
        "source": source,
        "duration": duration,
        "plays": plays,
        "likes": likes,
        "image": image,
        "comments": comments,
        "narration_url": narrationUrl
      };
  @override
  String toString() {
    return articleToJson([this]);
  }
}
