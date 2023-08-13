import 'package:flutter_testing_demo/models/article.dart';
import 'package:flutter_testing_demo/providers/articles_provider.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_testing_demo/service/fake_http_service.dart';
import 'package:mocktail/mocktail.dart';

class MockNewsService extends Mock implements NewsService {}

void main() {
  // system under test
  late ArticlesProvider articlesProvider;
  late MockNewsService mockNewsService;

  setUp(() {
    mockNewsService = MockNewsService();
    articlesProvider = ArticlesProvider(newsService: mockNewsService);
  });

  group("getArticles", () {
    test("initial values are correct", () {
      expect(articlesProvider.articles, []);
      expect(articlesProvider.isLoading, false);
    });

    test("gets articles using news service", () async {
      when(() => mockNewsService.fetchArticles()).thenAnswer((_) async => []);
      await articlesProvider.fetchArticles();
      verify(() => mockNewsService.fetchArticles()).called(1);
    });

    test("description", () async {
      
    });

  });
}
