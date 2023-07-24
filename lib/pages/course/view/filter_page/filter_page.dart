import 'package:cniao/common/icons.dart';
import 'package:cniao/common/values/colors.dart';
import 'package:cniao/common/values/font_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:math';


class FilterTab extends StatelessWidget {
  const FilterTab({super.key, required this.title, this.onTap, required this.isSelected});

  final String title;
  final bool isSelected;
  
  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Row(
          children: [
            Text(
              title,
              style: TextStyle(
                  fontSize: AppFontSize.normalSp, color: AppColors.black),
            ),
            Padding(
                padding: const EdgeInsets.only(left: 1),
                child: Transform.rotate(angle: isSelected ? pi : 0, child: Icon(
                  CNWFonts.down,
                  size: 32.sp,
                  color: isSelected ? Colors.red : Colors.black,
                ),) 
            ),
            
          ],
        ));
  }
}
