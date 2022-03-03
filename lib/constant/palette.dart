import 'package:flutter/material.dart';

class Palette {

   static const Color basicColor =  Colors.blue;
   static const Map<int, Color> textColorSwatch = {
      50: Color.fromRGBO(42, 42, 42, 0.10196078431372549),
      100: Color.fromRGBO(42, 42, 42, 0.2),
      200: Color.fromRGBO(42, 42, 42, 0.30196078431372547),
      300: Color.fromRGBO(42, 42, 42, 0.4),
      400: Color.fromRGBO(42, 42, 42, 0.5019607843137255),
      500: Color.fromRGBO(42, 42, 42, .6),
      600: Color.fromRGBO(42, 42, 42, .7),
      700: Color.fromRGBO(42, 42, 42, .8),
      800: Color.fromRGBO(42, 42, 42, .9),
      900: Color.fromRGBO(42, 42, 42, 1),
   };

   static const MaterialColor bgColor = MaterialColor(000000,textColorSwatch);


   static const Color shadowColor = Colors.red;

}