import 'package:cached_network_image/cached_network_image.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cniao/common/application.dart';
import 'package:cniao/models/adbanner.dart';
import 'package:cniao/route/routes.dart';
import 'package:flutter/material.dart';

class ImageBanner extends StatelessWidget {
  const ImageBanner({super.key, required this.banners});
  final List<AdBanner> banners;

  @override
  Widget build(BuildContext context) {
    // return ClipRRect(
    //   borderRadius: BorderRadius.circular(10),
    //   child: CarouselSlider(
    //     // 如果不设置高度，则按照16:9的比例自动生成
    //     options: CarouselOptions(height: 200, viewportFraction: 1.0, autoPlay: true, pageSnapping: true, onPageChanged: (index, reason){

    //     },),
    //     items: banners.map((banner) {
    //       return Builder(builder: ((context) {
    //            return GestureDetector(
    //               onTap: () {
    //                 // Application.router.navigateTo(context, Routes.webViewPage);
    //               },
    //              child: CachedNetworkImage(
    //               imageUrl: banner.imgUrl ?? "",
    //               // color: Colors.blue,
    //               fit: BoxFit.cover,
    //                          ),
    //            );
    //         // );
    //       }));
    //     }).toList(),
    //   ),
    // );

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: AspectRatio(
          // height:  250,
          // banners.isEmpty 解决第一次进来小圆点不断刷新的情况
          aspectRatio: 16 / 9,
          child: banners.isEmpty ? Container() : Swiper(
            itemBuilder: (context, index) {
              return CachedNetworkImage(
                 imageUrl: banners[index].imgUrl ?? "",
                 // color: Colors.blue,
                 fit: BoxFit.cover,
               );
            },
            itemCount: banners.length,
            pagination: const SwiperPagination(),
            // controller: SwiperController(),
            // containerHeight: (screenWidth / 1920 * 400) + 30,
            onTap: (index) => Application.navigateTo(context, Routes.webViewPage, params: {"url": banners[index].redirectUrl}),
            autoplay: true,
          ),
        ),
    );
  }
}
