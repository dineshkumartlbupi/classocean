import 'package:flutter/material.dart';

class UiHelper{
  static CustomImage({required String imgurl}){
    return Image.asset("assets/images/$imgurl");
  }
}