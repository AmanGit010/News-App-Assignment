import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../../../core/constants/urls.dart';
import '../../../core/models/news_model.dart';

class NewsRepo {
  Future<NewsModel?> fetchNews() async {
    final response = await http.get(Uri.parse(apiURL));

    if (kDebugMode) {
      print(response.body);
    }
    if (response.statusCode == 200) {
      final resBody = jsonDecode(response.body);
      return NewsModel.fromJson(resBody);
    } else {
      return null;
    }
  }
}
