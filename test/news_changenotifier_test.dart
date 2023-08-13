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

    final articlesFromService = List.generate(
      3,
      (index) => Article(
        title: "Test $index",
        content: "Test $index content",
      ),
    );

    void setupNewsServiceReturns3Articles() {
      when(() => mockNewsService.fetchArticles())
          .thenAnswer((_) async => articlesFromService);
    }

    test("initial values are correct", () {
      expect(articlesProvider.articles, []);
      expect(articlesProvider.isLoading, false);
    });

    test(
      "gets articles using news service",
      () async {
        setupNewsServiceReturns3Articles();
        await articlesProvider.fetchArticles();
        expect(3, articlesProvider.articles.length);
        verify(() => mockNewsService.fetchArticles()).called(1);
      },
    );

    test(
      """
      indicates loading of data
      assign articles gotten from fake api to the provider
      indicated that data is not loaded anymore
      """,
      () async {
        setupNewsServiceReturns3Articles();
        final result = articlesProvider.fetchArticles();
        expect(articlesProvider.isLoading, true);
        await result;
        expect(articlesProvider.articles, articlesFromService);
        expect(articlesProvider.isLoading, false);
      },
    );
  });
}
