import 'package:news_app/features/news/domain/entities/news_entity.dart';

class NewsModel extends NewsEntity {
  NewsModel({
    super.id,
    required super.author,
    required super.content,
    required super.date,
    required super.description,
    required super.imageUrl,
    required super.sourceName,
    required super.title,
    required super.url,
  });

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "author": author,
      "content": content,
      "date": date.toString(),
      "description": description,
      "imageUrl": imageUrl,
      "sourceName": sourceName,
      "title": title,
      "url": url,
    };
  }

  factory NewsModel.fromJson(Map<String, dynamic> map) {
    return NewsModel(
      id: map['id'],
      author: map["author"] ?? 'Unknown',
      content: map["content"] ?? ' ',
      date:
          map['publishedAt'] != null
              ? DateTime.tryParse(map['publishedAt']) ?? DateTime.now()
              : DateTime.now(),
      description: map['description'] ?? '',
      imageUrl: map['urlToImage'] ?? map['imageUrl'] ?? '',
      sourceName: (map['source']?['name']) ?? map['sourceName'] ?? '',
      title: map['title'] ?? '',
      url: map['url'] ?? '',
    );
  }

  factory NewsModel.fromEntity(NewsEntity entity) {
    return NewsModel(
      id: entity.id,
      author: entity.author,
      content: entity.content,
      date: entity.date,
      description: entity.description,
      imageUrl: entity.imageUrl,
      sourceName: entity.sourceName,
      title: entity.title,
      url: entity.url,
    );
  }

  NewsEntity toEntity() {
    return NewsEntity(
      id: id,
      author: author,
      content: content,
      date: date,
      description: description,
      imageUrl: imageUrl,
      sourceName: sourceName,
      title: title,
      url: url,
    );
  }
}
