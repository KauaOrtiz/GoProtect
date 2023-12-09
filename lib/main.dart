import 'package:flutter/material.dart';

import 'pages/splashArt.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Go Protect',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        primarySwatch: Colors.purple,
        primaryColor: Colors.black45,
        colorScheme: ColorScheme(
          primary: Color.fromRGBO(50, 56, 76, 1.0),
          secondary: Color.fromRGBO(62, 96, 111, 1),
          tertiary: Color.fromRGBO(149, 205, 213, 1),
          surface: Color.fromRGBO(102, 165, 173, 1),
          background: Colors.black45,
          error: Colors.black45,
          onPrimary: Colors.black45,
          onSecondary: Colors.black45,
          onSurface: Colors.black45,
          onBackground: Colors.black45,
          onError: Colors.black45,
          brightness: Brightness.light,
        ),
      ),
      home: const SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
          ],
        ),
      ),
    );
  }
}
