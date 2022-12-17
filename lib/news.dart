import 'dart:convert';

import 'article_model.dart';
import 'package:http/http.dart' as http;

class NewsClass {
  List<ArticleModel> news = [];

  Future<void> getNews() async {
    String url = "https://api.sampleapis.com/futurama/characters";
    var response = await http.get(Uri.parse(url));
    var jsondata = jsonDecode(response.body);
    for (var i = 0; i < jsondata.length; i++) {
      ArticleModel articleModel = ArticleModel(
          imageurl: jsondata[i]["images"]["main"],
          firstname: jsondata[i]["name"]["first"],
          lastname: jsondata[i]["name"]["last"],
          middlename: jsondata[i]["name"]["middle"],
          sayings: jsondata[i]["sayings"]);
      news.add(articleModel);
    }
  }
}
