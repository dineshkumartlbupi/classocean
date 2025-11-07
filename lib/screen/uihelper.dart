import 'package:flutter/material.dart';

class UiHelper {
  static CustomImage({required String imgurl}) {
    return Image.asset("assets/images/$imgurl");
  }

  static CustomText({
    required String text,
    required double fontsize,
    String? fontfamily,
    FontWeight? fontweight,
    Color? color,
  }) {
    return Text(
      text,
      style: TextStyle(
        fontSize: fontsize,
        fontFamily: fontfamily ?? "regular",
        color: color ?? Color(0xff625D5D),
        fontWeight: fontweight??FontWeight.normal
      ),
    );
  }
}
