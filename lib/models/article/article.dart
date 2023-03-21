import 'package:app_jamaah_boilerplate/models/admin/admin.dart';
import 'package:app_jamaah_boilerplate/models/category/category.dart';
import 'package:app_jamaah_boilerplate/models/pict/pict.dart';

class ArticleList {
  final List<Article> articles;

  ArticleList({
    this.articles,
  });

  factory ArticleList.fromJson(List<dynamic> json) {
    List<Article> articles = List<Article>();
    articles = json.map((article) => Article.fromJson(article)).toList();

    return ArticleList(
      articles: articles,
    );
  }
}


class Article {
  String title;
  String content;
  String status;
  Pict pict;
  String metaDescription;
  String metaKeywords;
  String createdAt;
  String updatedAt;
  Category category;
  Admin admin;

  Article(
      {this.title,
      this.content,
      this.status,
      this.pict,
      this.metaDescription,
      this.metaKeywords,
      this.createdAt,
      this.updatedAt,
      this.category,
      this.admin
      });

  Article.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    content = json['content'];
    status = json['status'];
    pict = json['pict'] != null ? new Pict.fromJson(json['pict']) : null;
    metaDescription = json['meta_description'];
    metaKeywords = json['meta_keywords'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    category = json['category'] != null
        ? new Category.fromJson(json['category'])
        : null;
    admin = json['admin'] != null ? new Admin.fromJson(json['admin']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['content'] = this.content;
    data['status'] = this.status;
    if (this.pict != null) {
      data['pict'] = this.pict.toJson();
    }
    data['meta_description'] = this.metaDescription;
    data['meta_keywords'] = this.metaKeywords;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.category != null) {
      data['category'] = this.category.toJson();
    }
    if (this.admin != null) {
      data['admin'] = this.admin.toJson();
    }
    return data;
  }
}