
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../Color_Fonts_Error/Fonts.dart';

class Userdetiles extends StatelessWidget {

  final String title,SvgPath;
  final double? width,height;
  final Color? color;
  const Userdetiles({
    super.key,
    required this.title,
    required this.SvgPath,
    this.width  ,
    this.height,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      // mainAxisSize:MainAxisSize.min
      children: [
        SvgPicture.asset(SvgPath,
        width: width,
        height: height,
          color: color,
        ),
        SizedBox(width: 10,),
        Flexible(
          child: Text(
            title,
            maxLines:2,
            overflow: TextOverflow.ellipsis,
            softWrap: false,
            style: MyTextStyle.medium.copyWith(
            fontSize: 14.5,
            color: Colors.black,
          ),),
        ),
      ],
    );
  }
}
