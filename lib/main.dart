import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '/pages/visionPage.dart';
import 'pages/splashArt.dart';
import 'pages/workerPage.dart';

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
  List<Widget> cards = [];

  void addCard(String name, String function) {
    setState(() {
      cards.add(
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.circular(10.0),
          ),
          margin: EdgeInsets.symmetric(vertical: 8),
          child: ListTile(
            title: Text(name),
            subtitle: Text(function),
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'GoProtect',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                fontFamily: "Syne",
                color: Theme.of(context).colorScheme.primary,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.2,
            padding: EdgeInsets.all(25),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'Tudo certo\npara entrar?',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w800,
                      fontFamily: "ProzaLibre",
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
                SvgPicture.asset(
                  "assets/icons/go_protect_icon.svg",
                  height: 100,
                  width: 100,
                ),
              ],
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: BorderRadius.circular(15.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 1,
                  offset: Offset(0, 4),
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          Container(
            width: MediaQuery.of(context).size.width * 0.9,
            height: MediaQuery.of(context).size.height * 0.55,
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: BorderRadius.circular(15.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.4),
                    spreadRadius: 1,
                    blurRadius: 2,
                    offset: Offset(0, 0),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Colaboradores no setor',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      fontFamily: "ProzaLibre",
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  SizedBox(height: 10),
                  Expanded(
                    child: ListView.builder(
                      itemCount: cards.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              cards.removeAt(index);
                            });
                          },
                          child: Container(
                            child: cards[index],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.all(20),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => WorkerPage(onAddCard: addCard),
                            //builder: (context) => VisionPage(),
                          ),
                        );
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            //builder: (context) => WorkerPage(onAddCard: addCard),
                            builder: (context) => VisionPage(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 30),
                      ),
                      child: Text(
                        'Avançar',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w100,
                          fontFamily: "ProzaLibre",
                          color: Theme.of(context).scaffoldBackgroundColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}