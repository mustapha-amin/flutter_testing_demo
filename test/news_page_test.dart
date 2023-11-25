import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_testing_demo/models/article.dart';
import 'package:flutter_testing_demo/providers/articles_provider.dart';
import 'package:flutter_testing_demo/screens/home.dart';
import 'package:flutter_testing_demo/service/fake_http_service.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';

class MockNewsService extends Mock implements NewsService {}

void main() {
  late MockNewsService mockNewsService;

  setUp(() {
    mockNewsService = MockNewsService();
  });

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

  void setupNewsServiceReturns3ArticlesAfter2SecondsWait() {
    when(() => mockNewsService.fetchArticles()).thenAnswer((_) async {
      await Future.delayed(const Duration(seconds: 5));
      return articlesFromService;
    });
  }

  Widget createWidgetUnderTest() {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          brightness: Brightness.dark,
          seedColor: Colors.deepOrange,
        ),
      ),
      home: ChangeNotifierProvider(
        create: (_) => ArticlesProvider(
          newsService: mockNewsService,
        ),
        child: const Home(),
      ),
    );
  }

  group("Couple of widget tests\n", () {
    testWidgets(
      "Appbar title is diplayed",
      (WidgetTester widgetTester) async {
        setupNewsServiceReturns3Articles();
        await widgetTester.pumpWidget(createWidgetUnderTest());
        expect(find.text("News 24"), findsWidgets);
      },
    );

    testWidgets(
      """
        Test that circlular progress indicator
        is diplayed while waiting for articles are loading""",
      (WidgetTester widgetTester) async {
        setupNewsServiceReturns3ArticlesAfter2SecondsWait();
        await widgetTester.pumpWidget(createWidgetUnderTest());
        await widgetTester.pump();
        expect(find.byType(CircularProgressIndicator), findsOneWidget);
        await widgetTester.pumpAndSettle();
      },
    );
  });
}
