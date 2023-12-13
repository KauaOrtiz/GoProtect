import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../main.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
      Duration(seconds: 5),
          () {
        // Navega para a tela principal após o atraso
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const MyHomePage()),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SvgPicture.asset(
              "assets/icons/go_protect_icon.svg",
              height: 200,
              width: 200,
            ),
            SizedBox(height: 16), // Adiciona um espaçamento entre o SVG e o Texto
            Text(
              'GoProtect',
              style: TextStyle(
                fontSize: 36,
                fontFamily: "Syne",
                fontWeight: FontWeight.w800,
                color: Theme.of(context).colorScheme.primary, // Mude a cor conforme desejado
              ),
            ),
            SizedBox(height: 8), // Adiciona um espaçamento entre o SVG e o Texto
            Text(
              'Siga em frente...\nMas com segurança!',
              textAlign: TextAlign.center, // Centraliza o texto
              style: TextStyle(
                fontSize: 20,
                fontFamily: "Roboto",
                fontWeight: FontWeight.w400,
                color: Theme.of(context).colorScheme.secondary, // Mude a cor conforme desejado
              ),
            ),
          ],
        ),
      ),
    );
  }
}
