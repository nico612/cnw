

import 'package:cached_network_image/cached_network_image.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:cniao/common/application.dart';
import 'package:cniao/models/adbanner.dart';
import 'package:cniao/router/routers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ImageBanner extends StatelessWidget {

  const ImageBanner({super.key, required this.banners});
  final List<AdBanner> banners;

  @override
  Widget build(BuildContext context) {

    return Container(
        height:  200.h,
        color: Colors.red,
        child: Swiper(
          itemBuilder: (context, index) {
            return ClipRRect(
             borderRadius: BorderRadius.circular(10.w),
             child: CachedNetworkImage(
               imageUrl: banners[index].imgUrl ?? "",
               // color: Colors.blue,
               fit: BoxFit.fill,

             ),
            );
          },
          itemCount: banners.length,
          pagination: const SwiperPagination(),
          controller: SwiperController(),
          // containerHeight: (screenWidth / 1920 * 400) + 30,
          onTap: (index) => Application.navigateTo(context, Routers.webViewPage, params: {"url": banners[index].redirectUrl}),
          autoplay: true,
        ),
      );
  }
} 