
import 'package:flutter/material.dart';
import 'package:covid_19_tracker/datasource.dart';
import 'package:covid_19_tracker/homepage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme:    ThemeData(
            fontFamily: 'Circular',
               primaryColor: primaryBlack,
          ) ,
          home: HomePage(),
        );
      }


}

