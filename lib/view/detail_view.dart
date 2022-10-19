import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:test_solusi_digital/utils/colors.dart';
import 'package:test_solusi_digital/view_model/article_view_model.dart';

class DetailNews extends StatelessWidget {
  DetailNews({Key key}) : super(key: key);
  final article = Get.put(ArticleViewModel());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Berita"),
      ),
      body: Padding(
        padding: EdgeInsets.all(5.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(() => ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: article.articleById().urlToImage != null
                      ? Image.network(
                          article.articleById().urlToImage,
                          width: 100.w,
                          height: 25.h,
                          fit: BoxFit.cover,
                        )
                      : Image.asset(
                          "asset/images/image_news.png",
                          width: 100.w,
                          height: 25.h,
                          fit: BoxFit.cover,
                        ),
                )),
            Padding(
              padding: EdgeInsets.only(top: 2.h),
              child: Obx(() => Text(
                    article.articleById().title,
                    style: TextStyle(
                        color: ColorApp.greyColor,
                        fontSize: 15.sp,
                        fontFamily: "Rubik",
                        fontWeight: FontWeight.w500),
                    textAlign: TextAlign.justify,
                  )),
            ),
            Obx(() => Text("sumber : " + article.articleById().author,
                style: TextStyle(
                    color: ColorApp.grey,
                    fontSize: 10.sp,
                    fontFamily: "Rubik",
                    fontWeight: FontWeight.w400))),
            Padding(
              padding: EdgeInsets.only(bottom: 2.w),
              child: Obx(
                () => Text(article.articleById().publishedAt.toString(),
                    style: TextStyle(
                        color: ColorApp.grey,
                        fontSize: 10.sp,
                        fontFamily: "Rubik",
                        fontWeight: FontWeight.w400)),
              ),
            ),
            Flexible(
              child: Obx(
                () => Text(
                  article.articleById().content,
                  style: TextStyle(
                      color: ColorApp.greyColor,
                      fontSize: 10.sp,
                      fontFamily: "Rubik",
                      fontWeight: FontWeight.w400),
                  textAlign: TextAlign.justify,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
