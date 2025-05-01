import 'package:news_app/features/news/domain/entities/news_entity.dart';

class NoParams {}

class CategoryParams {
  String category;
  CategoryParams(this.category);
}

class DeleteParam {
  int id;
  DeleteParam(this.id);
}

class SaveParam {
  NewsEntity news;
  SaveParam({required this.news});
}
