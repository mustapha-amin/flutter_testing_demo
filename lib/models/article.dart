class Article {
  final String title;
  final String content;

  Article({
    required this.title,
    required this.content,
  });

  Article copyWith({
    String? title,
    String? content,
  }) {
    return Article(
      title: title ?? this.title,
      content: content ?? this.content,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Article &&
          runtimeType == other.runtimeType &&
          title == other.title &&
          content == other.content;

  @override
  int get hashCode => title.hashCode ^ content.hashCode;

  @override
  String toString() {
    return 'Article{title: $title, content: $content}';
  }
}
