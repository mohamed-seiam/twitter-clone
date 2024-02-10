import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:twitter_clone/theme/theme.dart';

class RoundedSmallButton extends StatelessWidget {
  const RoundedSmallButton(
      {super.key,
      required this.onTap,
      required this.label,
       this.backGroundColor = Pallete.whiteColor,
       this.textColor = Pallete.backgroundColor});

  final VoidCallback onTap;
  final String label;
  final Color backGroundColor;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Chip(
        label: Text(
          label,
          style: TextStyle(color: textColor,fontSize: 12.sp),
        ),
        backgroundColor: backGroundColor,
        labelPadding: EdgeInsets.symmetric(horizontal: 16.w,vertical: 3.h),
      ),
    );
  }
}
