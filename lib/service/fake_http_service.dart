import 'package:flutter_testing_demo/models/article.dart';
import 'package:flutter_lorem/flutter_lorem.dart';

class NewsService {
  final articles = List.generate(
    20,
    (_) => Article(
      title: lorem(
        paragraphs: 1,
        words: 5,
      ),
      content: lorem(
        paragraphs: 10,
        words: 700,
      ),
    ),
  );

  Future<List<Article>> fetchArticles() async {
    await Future.delayed(const Duration(seconds: 5));
    return articles;
  }
}
