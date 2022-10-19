import 'package:get/get.dart';
import 'package:test_solusi_digital/model/news_model.dart';
import 'package:test_solusi_digital/service/news_service.dart';

class ArticleViewModel extends GetxController {
  var isLoading = true.obs;
  var listarticle = List<Article>.empty().obs;
  var pageSize = 20.obs;
  var current = 0.obs;
  var idArtikel = "".obs;
  @override
  void onInit() {
    getArticle();
    super.onInit();
  }

  Article articleById() {
    return listarticle
        .firstWhere((element) => element.source.id == idArtikel.value);
  }

  Future getArticle() async {
    isLoading(true);
    try {
      var res = await NewsServices().getNews(page: 10.toString());
      if (res[0] == "ok") {
        listarticle.assignAll(res[1]);
      } else {
        listarticle.assignAll([]);
      }
    } finally {
      isLoading(false);
    }
    return listarticle;
  }
}
