// To parse this JSON data, do
//
//     final article = articleFromJson(jsonString);

import 'dart:convert';
import 'package:flutter/foundation.dart';

List<Article> articleFromJson(String str) => List<Article>.from(json.decode(str).map((x) => Article.fromJson(x)));

String articleToJson(List<Article> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Article {
  Article({
    @required this.title,
    this.author,
    @required this.source,
    @required this.duration,
    @required this.image,
    this.plays = 0,
    this.likes = 0,

  });

  final String title;
  final String author;
  final String source;
  final String duration;
  final String image;
  final int plays;
  final int likes;

  factory Article.fromJson(Map<String, dynamic> json) => Article(
    title: json["title"],
    author: json["author"],
    source: json["source"],
    duration: json["duration"],
    plays: json["plays"],
    likes: json["likes"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "author": author,
    "source": source,
    "duration": duration,
    "plays": plays,
    "likes": likes,
    "image": image,
  };
}


