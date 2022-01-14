import 'package:flutter/material.dart';
import 'package:whatsapp_direct/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.green,
        fontFamily: 'saraff',
      ),
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
