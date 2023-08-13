import 'package:flutter/material.dart';
import 'package:flutter_testing_demo/providers/articles_provider.dart';
import 'package:flutter_testing_demo/service/fake_http_service.dart';
import 'package:provider/provider.dart';
import 'screens/home.dart';

void main() {
  runApp(MaterialApp(
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
        newsService: NewsService(),
      ),
      child: const Home(),
    ),
  ));
}
