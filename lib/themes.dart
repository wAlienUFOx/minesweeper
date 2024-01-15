import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
    splashColor: Colors.white,
    //fontFamily: 'SFProText',
    colorScheme: const ColorScheme.light(
      primary: Colors.white,
      background: Colors.grey,
      onBackground: Colors.black,
       secondaryContainer: Colors.white30,
       onSecondaryContainer: Color(0xffD9D9D9),
    ),
);

ThemeData darkTheme = ThemeData(
    splashColor: const Color(0xff2C2E30),
    //fontFamily: 'SFProText',
    colorScheme: const ColorScheme.dark(
      primary: Colors.white54,
      background: Color(0xff151616),
      onBackground: Color.fromARGB(255, 100, 100, 100),//0xff2C2E30),
       secondaryContainer: Color(0xff343434),
       onSecondaryContainer: Color(0xff444545),
    ),
);