import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icon.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:test_solusi_digital/model/news_model.dart';
import 'package:test_solusi_digital/utils/colors.dart';
import 'package:sizer/sizer.dart';
import 'package:test_solusi_digital/view_model/article_view_model.dart';

import 'detail_view.dart';
class HomeView extends StatelessWidget {
  HomeView({Key key}) : super(key: key);
  final article = Get.put(ArticleViewModel());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            elevation: 0.0,
            backgroundColor: Colors.white,
            title: Image.asset("asset/images/logo.png"),
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 5.0),
                      child: Text(
                        "Hi, Bagus",
                        style: TextStyle(
                            fontFamily: "Rubik",
                            color: ColorApp.greyColor,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    LineIcon.userCircleAlt(
                      color: ColorApp.greyColor,
                      size: 7.w,
                    ),
                  ],
                ),
              ),
            ]
          ),
          body: SingleChildScrollView(
          child: Column(
            children: [
              const SearchWidget(),
              const ContainerAntrian(),
              const ContainerMenu(),
              ContainerCarousel(),
              Container(
                  color: Colors.white,
                  margin: const EdgeInsets.only(top: 15.0),
                  padding: EdgeInsets.only(top: 2.h),
                  child: Obx(() => FutureBuilder(
                      future: article.getArticle(),
                      builder: (context, snapshot) {
                        return ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: article.listarticle.length ?? 0,
                            itemBuilder: (context, i) {
                              Article x = article.listarticle[i];
                              return ContainerContent(
                                author: x.author,
                                title: x.title,
                                content: x.content,
                                image: x.urlToImage,
                                date: x.publishedAt.toString(),
                                id: x.source.id,
                              );
                            }
                        );
                      }
                  ),
                ),
              ),
            ],
          ),
        ),
      );
  }
}
class ContainerContent extends StatelessWidget {
  ContainerContent({
    Key key,
    this.title,
    this.author,
    this.content,
    this.image,
    this.date,
    this.id,
  }) : super(key: key);
  String title;
  String author;
  String content;
  String image;
  String date;
  String id;
  final article = Get.put(ArticleViewModel());
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 1.h),
      padding: EdgeInsets.fromLTRB(4.w, 1.w, 5.w, 1.w),
      color: Colors.white,
      width: 100.w,
      height: 55.h,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: image != null
                ? Image.network(
                    image,
                    width: 100.w,
                    height: 25.h,
                    fit: BoxFit.cover,
                  )
                : Image.asset(
                    "asset/images/foot.png",
                    width: 100.w,
                    height: 25.h,
                    fit: BoxFit.cover,
                  ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 2.h),
            child: Text(title,
                style: TextStyle(
                    color: ColorApp.greyColor,
                    fontSize: 15.sp,
                    fontFamily: "Rubik",
                    fontWeight: FontWeight.w500)),
          ),
          Text("sumber : " + author,
              style: TextStyle(
                  color: ColorApp.grey,
                  fontSize: 10.sp,
                  fontFamily: "Rubik",
                  fontWeight: FontWeight.w400)),
          Padding(
            padding: EdgeInsets.only(bottom: 2.w),
            child: Text(date,
                style: TextStyle(
                    color: ColorApp.grey,
                    fontSize: 10.sp,
                    fontFamily: "Rubik",
                    fontWeight: FontWeight.w400)),
          ),
          Flexible(
            child: Text(
              content,
              style: TextStyle(
                  color: ColorApp.greyColor,
                  fontSize: 10.sp,
                  fontFamily: "Rubik",
                  fontWeight: FontWeight.w400),
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.justify,
              maxLines: 3,
            ),
          ),
          InkWell(
            onTap: () {
              article.idArtikel.value = id;
              Get.to(() => DetailNews());
            },
            child: Padding(
              padding: EdgeInsets.only(top: 2.w),
              child: Text("Baca Selengkapnya...",
                  style: TextStyle(
                      color: Colors.blue,
                      fontSize: 10.sp,
                      fontFamily: "Rubik",
                      fontWeight: FontWeight.w400)),
            ),
          ),
        ],
      ),
    );
  }
}

class ContainerCarousel extends StatelessWidget {
  ContainerCarousel({
    Key key,
  }) : super(key: key);
  final article = Get.put(ArticleViewModel());

  CarouselController buttonCarouselController = CarouselController();
  List imgList = [
    "asset/images/diskon.png",
    "asset/images/foot.png"
  ];
  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 15.0),
      width: 100.w,
      height: 37.h,
      color: Colors.white,
      child: Column(
        children: [
          CarouselSlider(
            items: imgList.map((imgUrl) {
              return Builder(
                builder: (BuildContext context) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      imgUrl,
                      fit: BoxFit.contain,
                    ),
                  );
                },
              );
            }).toList(),
            carouselController: buttonCarouselController,
            options: CarouselOptions(
                autoPlay: false,
                enlargeCenterPage: true,
                viewportFraction: 0.9,
                aspectRatio: 2.0,
                initialPage: 2,
                onPageChanged: (index, reason) {
                  article.current.value = index;
                }),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: map<Widget>(imgList, (index, url) {
              return Obx(() => Container(
                    width: 10.0,
                    height: 10.0,
                    margin: const EdgeInsets.symmetric(
                        vertical: 3.0, horizontal: 2.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: article.current == index
                          ? ColorApp.grey
                          : Colors.blue,
                    ),
                  ));
            }),
          ),
        ],
      ),
    );
  }
}

class ContainerMenu extends StatelessWidget {
  const ContainerMenu({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.w,
      height: 30.h,
      color: Colors.white,
      padding: EdgeInsets.fromLTRB(5.w, 1.w, 5.w, 1.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconMenu(
                color: Colors.blue,
                icon: LineIcon.hospital(color: Colors.white, size: 10.w),
                text: "KLINIK TERDEKAT",
              ),
              IconMenu(
                color: Colors.blue,
                icon:
                    Icon(Icons.notifications, color: Colors.white, size: 10.w),
                text: "NOTIFIKASI",
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconMenu(
                color: Colors.blue,
                icon: LineIcon.list(
                  color: Colors.white,
                  size: 10.w,
                ),
                text: "RIWAYAT",
              ),
              IconMenu(
                color: ColorApp.indigo,
                icon: LineIcon.starAlt(
                  color: Colors.white,
                  size: 10.w,
                ),
                text: "BERI NILAI",
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconMenu(
                icon: Icon(Icons.photo, color: Colors.white, size: 10.w),
                text: "DATA SCAN",
                color: ColorApp.indigo,
              ),
              IconMenu(
                icon: Icon(Icons.settings, color: Colors.white, size: 10.w),
                text: "PENGATURAN",
                color: Colors.pink,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class IconMenu extends StatelessWidget {
  IconMenu({
    Key key,
    this.icon,
    this.text,
    this.color,
  }) : super(key: key);

  Widget icon;
  String text;
  Color color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 12.h,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
              width: 14.w,
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadiusDirectional.circular(17)),
              child: icon),
          Text(text,
              style: TextStyle(
                  fontFamily: "Rubik",
                  color: ColorApp.greyColor,
                  fontWeight: FontWeight.w500,
                  fontSize: 9.sp))
        ],
      ),
    );
  }
}
class ContainerAntrian extends StatelessWidget {
  const ContainerAntrian({
    Key key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.w,
      height: 25.h,
      margin: EdgeInsets.fromLTRB(4.w, 0, 4.w, 1.w),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
            colors: [Color(0xff0093DD), Color(0xffDD127B)],
            begin: FractionalOffset(0.0, 0.9),
            end: FractionalOffset(0.9, 0.0),
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp),
        borderRadius: BorderRadius.circular(10),
        color: Colors.red,
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Padding(
          padding: EdgeInsets.fromLTRB(7.w, 2.w, 4.w, 1.w),
          child: Text("INFO ANTRIAN",
              style: TextStyle(
                  letterSpacing: 1.0,
                  fontFamily: "Rubik",
                  fontWeight: FontWeight.w500,
                  fontSize: 12.sp,
                  color: Colors.white)),
        ),
        const Divider(color: Colors.white),
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircularPercentIndicator(
                    radius: 70.0,
                    startAngle: 0.0,
                    lineWidth: 3.0,
                    percent: 0.9,
                    progressColor: ColorApp.limeColor,
                    center: Text(
                      "21",
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: "Rubik",
                          fontSize: 25.sp),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 2.0),
                    child: Text(
                      "Nomor antrian",
                      style: TextStyle(
                          fontFamily: "Rubik",
                          fontSize: 9.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    ),
                  )
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircularPercentIndicator(
                    startAngle: 170.0,
                    radius: 70.0,
                    lineWidth: 3.0,
                    percent: 0.9,
                    progressColor: ColorApp.limeColor,
                    center: Text(
                      "5",
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: "Rubik",
                          fontSize: 25.sp),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 2.0),
                    child: Text(
                      "Sisa antrian",
                      style: TextStyle(
                          fontFamily: "Rubik",
                          fontWeight: FontWeight.w500,
                          fontSize: 9.sp,
                          color: Colors.white),
                    ),
                  )
                ],
              ),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 4.w),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Dokter anda',
                              style: TextStyle(
                                  color: ColorApp.limeColor,
                                  fontFamily: "Rubik",
                                  fontWeight: FontWeight.w500,
                                  fontSize: 9.sp),
                            ),
                            Text(
                              'dr. Rina Agustina',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: "Rubik",
                                  fontWeight: FontWeight.w500,
                                  fontSize: 9.sp),
                            )
                          ]),
                    ),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Klinik / RS anda',
                            style: TextStyle(
                                color: ColorApp.limeColor,
                                fontFamily: "Rubik",
                                fontWeight: FontWeight.w500,
                                fontSize: 9.sp),
                          ),
                          Text(
                            'RS. National Hospital',
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: "Rubik",
                                fontWeight: FontWeight.w500,
                                fontSize: 9.sp),
                          )
                        ])
                  ],
                ),
              ),
            ])
      ]),
    );
  }
}
class SearchWidget extends StatelessWidget {
  const SearchWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.w,
      height: 10.h,
      color: Colors.white,
      padding: EdgeInsets.fromLTRB(4.w, 1.w, 4.w, 0),
      child: TextFormField(
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: const BorderSide(color: ColorApp.grey, width: 0.0),
            borderRadius: BorderRadius.circular(25.0),
          ),
          contentPadding: EdgeInsets.fromLTRB(5.w, 1.w, 5.w, 1.w),
          filled: true,
          fillColor: ColorApp.greyWhite,
          hintStyle: TextStyle(
              color: ColorApp.grey, fontFamily: "Rubik", fontSize: 12.sp),
          hintText: "Cari Klinik / Rumah Sakit",
        ),
      ),
    );
  }
}
