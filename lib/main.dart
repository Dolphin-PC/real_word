import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:real_word/page/IndexPage.dart';
import 'package:real_word/page/MyHomePage.dart';
import 'package:real_word/provider/WordProvider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget _build(BuildContext context) {
    return MaterialApp(
      title: 'Real Word',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ChangeNotifierProvider(
        create: (_) => WordProvider(),
        child: IndexPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => WordProvider(),
        child: MaterialApp(
          title: 'Real Word',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          initialRoute: '/',
          routes: {
            '/': (context) => IndexPage(),
            '/home': (context) => MyHomePage(),
          },
        ));
  }
}
