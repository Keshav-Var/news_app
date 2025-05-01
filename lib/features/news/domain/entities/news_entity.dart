class NewsEntity {
  int? id;
  final String? sourceName;
  final String? title;
  final String? content;
  final String? description;
  final String? url;
  final String? imageUrl;
  final String? author;
  final DateTime? date;
  NewsEntity({
    this.id,
    required this.author,
    required this.content,
    required this.date,
    required this.description,
    required this.imageUrl,
    required this.sourceName,
    required this.title,
    required this.url,
  });
}
