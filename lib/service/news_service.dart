import 'package:http/http.dart' as http;
import 'package:test_solusi_digital/model/news_model.dart';

class NewsServices {
  final String ip = "newsapi.org";
  Future<List> getNews({String page}) async {
    var x;
    final queryParameters = {
      'q': 'tesla',
      'pageSize': '10',
      'apiKey': '7dcebad4be1d429daee13ebf41db8cbb'
    };
    final res = await http
        .get(Uri.https("newsapi.org", "/v2/everything", queryParameters));
    if (res.statusCode == 200) {
      var response = newsModelFromJson(res.body);
      if (response.status == "ok") {
        x = ["ok", response.articles];
      } else {
        x = ["gak ok", response.status];
      }
    } else {
      x = ["gak 200", res.statusCode];
    }
    return x;
  }
}
