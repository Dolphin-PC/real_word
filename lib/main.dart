import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:real_word/page/IndexPage.dart';
import 'package:real_word/page/MyHomePage.dart';
import 'package:real_word/provider/CommProvider.dart';
import 'package:real_word/provider/WordProvider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => WordProvider()),
        ChangeNotifierProvider(create: (_) => CommProvider()),
      ],
      child: MaterialApp(
        title: 'Real Word',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/',
        routes: {
          IndexPage.routeName: (context) => const IndexPage(),
          MyHomePage.routeName: (context) => const MyHomePage(),
        },
      ),
    );
  }
}
