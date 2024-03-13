import 'package:news_app/core/models/news_model.dart';
import 'package:news_app/feature/main/repo/news_repo.dart';

class NewsView {
  final _repo = NewsRepo();

  Future<NewsModel?> fetchNews() async {
    final response = await _repo.fetchNews();
    return response;
  }
}
