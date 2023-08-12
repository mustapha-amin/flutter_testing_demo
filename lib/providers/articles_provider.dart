import 'package:flutter/material.dart';
import 'package:flutter_testing_demo/models/article.dart';
import 'package:flutter_testing_demo/service/fake_http_service.dart';

class ArticlesProvider extends ChangeNotifier {
  final NewsService newsService;

  ArticlesProvider({required this.newsService});

  bool isLoading = false;

  List<Article> _articles = [];

  List<Article> get articles => _articles;

  void toggleLoading() {
    isLoading = !isLoading;
    notifyListeners();
  }

  Future<List<Article>> fetchArticles() async {
    toggleLoading();
    _articles = await newsService.fetchArticles();
    toggleLoading();
    return _articles;
  }
}
