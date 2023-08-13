import 'package:flutter/material.dart';
import 'package:flutter_testing_demo/models/article.dart';
import 'package:flutter_testing_demo/providers/articles_provider.dart';
import 'package:flutter_testing_demo/screens/detail_screen.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ArticlesProvider>().fetchArticles();
    });
  }

  @override
  Widget build(BuildContext context) {
    var newsProvider = Provider.of<ArticlesProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "News 24",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
        ),
      ),
      body: newsProvider.isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: newsProvider.articles.length,
                itemBuilder: (context, index) {
                  Article article = newsProvider.articles[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  NewsDetailPage(article: article)));
                    },
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          title: Text(
                            article.title,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            article.content,
                            maxLines: 4,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
    );
  }
}
