import 'package:app/src/pages/buy_page.dart';
import 'package:flutter/material.dart';

import 'package:flutter/services.dart';

import 'src/pages/home_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(statusBarColor: Colors.transparent));

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'EcoTravel',
      initialRoute: 'homePage',
      routes: {'homePage': (BuildContext context) => HomePage(), 'pages/buy_page': (BuildContext context) => BuyPage()},
      theme: ThemeData(
        primaryColor: Colors.pinkAccent,
        canvasColor: Color.fromRGBO(55, 57, 84, 1.0),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Colors.pinkAccent,
        ),
      ),
    );
  }
}
