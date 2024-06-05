import 'package:dmrc/screens/homescreen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DMRC',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.greenAccent),
        canvasColor: Color(0xFF1D2228),
        cardColor: Colors.black,
        // colorScheme,
        // colorSchemeSeed,
        // dialogBackgroundColor,
        // disabledColor,
        // dividerColor,
        // focusColor,
        // highlightColor,
        // hintColor,
        // hoverColor,
        // indicatorColor,
        primaryColor: Color(0xFF1D2228),
        // primaryColorDark,
        // primaryColorLight,
        // primarySwatch,
        scaffoldBackgroundColor: Color(0xFF1D2228),
        // secondaryHeaderColor,
        // shadowColor,
        // splashColor,
        // unselectedWidgetColor,
        textTheme: Theme.of(context).textTheme.apply(bodyColor: Colors.white70, displayColor: Colors.white70),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}
