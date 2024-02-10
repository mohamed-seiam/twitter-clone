import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:twitter_clone/constants/assets_constance_file.dart';

class UiConstants {
  static AppBar appBar() {
    return AppBar(
      centerTitle: true,
      title: SvgPicture.asset(
        AssetsConstants.twitterLogo,
        height: 25.h,
        colorFilter: const ColorFilter.mode(Colors.blue,BlendMode.srcIn,),
      ),
    );
  }
}
