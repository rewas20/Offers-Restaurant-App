import 'package:flutter/material.dart';

class ThemesColor {

  Color? getColor(int id){
    switch(id){
      case 1:
        return const Color(0xffE32105);
      case 2:
        return const Color(0xff20AEFA);
      case 3:
        return const Color(0xff0E75AD);
      case 4:
        return const Color(0xffFAC820);
      case 5:
        return const Color(0xffAD1721);
      case 6:
        return const Color(0xffFA5314);
      case 7:
        return const Color(0xffF214FA);
      case 8:
        return const Color(0xffFF718E);
      case 9:
        return const Color(0xffFFF2CD);
      default:
        return Colors.white;
    }
}
}