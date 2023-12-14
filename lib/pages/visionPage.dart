import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_vision/flutter_vision.dart';
import 'package:flutter_vision_example/main.dart';
import 'package:flutter_vision_example/pages/workerPage.dart';
import 'package:image_picker/image_picker.dart';

import 'cameraScreen.dart';

// main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   DartPluginRegistrant.ensureInitialized();
//   runApp(
//     const MaterialApp(
//       home: VisionPage(onAddCard: ,),
//     ),
//   );
// }

class VisionPage extends StatefulWidget {
  const VisionPage({Key? key}) : super(key: key);

  @override
  State<VisionPage> createState() => _VisionPageState();
}

class _VisionPageState extends State<VisionPage> {
  late FlutterVision vision;
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
  void initState() {
    super.initState();
    vision = FlutterVision();
  }

  @override
  void dispose() async {
    super.dispose();
    await vision.closeTesseractModel();
    await vision.closeYoloModel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        automaticallyImplyLeading: false,
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
      body: YoloImageV8(vision: vision),
    );
  }
}

class YoloImageV8 extends StatefulWidget {
  final FlutterVision vision;
  const YoloImageV8({Key? key, required this.vision}) : super(key: key);

  @override
  State<YoloImageV8> createState() => _YoloImageV8State();
}

class _YoloImageV8State extends State<YoloImageV8> {
  late List<Map<String, dynamic>> yoloResults = [];
  File? imageFile;
  int imageHeight = 1;
  int imageWidth = 1;
  bool isLoaded = false;
  String displayText = 'Olá, quando estiver preparado\nclique para tirar a foto.';
  bool showButtons = true;


  @override
  void initState() {
    super.initState();
    loadYoloModel().then((value) {
      setState(() {
        yoloResults = [];
        isLoaded = true;
      });
    });
  }

  @override
  void dispose() async {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // 1º Container: Componente da Imagem
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            height: size.height * 0.6,
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: BorderRadius.circular(15.0), // Adicione esta linha
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Stack(
              fit: StackFit.expand,
              children: [
                imageFile != null ? Image.file(imageFile!) : const SizedBox(),
                //...displayBoxesAroundRecognizedObjects(size),
              ],
            ),
          ),
          // 2º Container: Texto Informativo
          Container(
            margin: EdgeInsets.all(20.0),
            padding: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3), // changes the position of shadow
                ),
              ],
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Text(
              displayText,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontFamily: "Roboto",
                fontWeight: FontWeight.w400,
                color: Theme.of(context).colorScheme.secondary, // Mude a cor conforme desejado
              ),
            ),
          ),
          // 3º Container: Botões
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20.0),
            child: showButtons
                ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: pickImage,
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 30),
                  ),
                  child: Text(
                    "Escolher uma foto",
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w100,
                      fontFamily: "ProzaLibre",
                      color: Theme.of(context).scaffoldBackgroundColor,
                    ),
                  ),
                ),
                SizedBox(width: 16.0), // Espaçamento entre os botões
                ElevatedButton(
                  onPressed: pickImage2,
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 30),
                  ),
                  child: Text(
                    "Tirar uma foto",
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w100,
                      fontFamily: "ProzaLibre",
                      color: Theme.of(context).scaffoldBackgroundColor,
                    ),
                  ),
                ),
              ],
            )
                : ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 30),
              ),
              child: Text(
                "Avançar",
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w100,
                  fontFamily: "ProzaLibre",
                  color: Theme.of(context).scaffoldBackgroundColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> loadYoloModel() async {
    await widget.vision.loadYoloModel(
        labels: 'assets/labelCustom.txt',
        modelPath: 'assets/modelCustom.tflite',
        modelVersion: "yolov8",
        quantization: false,
        numThreads: 2,
        useGpu: true);
    setState(() {
      isLoaded = true;
    });
  }

  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    // Capture a photo
    final XFile? photo = await picker.pickImage(source: ImageSource.gallery);
    if (photo != null) {
      setState(() {
        imageFile = File(photo.path);
      });
      yoloOnImage();
    }
  }

  Future<void> pickImage2() async {
    final cameras = await availableCameras();
    if (cameras.isEmpty) {
      print('No cameras available');
      return;
    }

    final frontCamera = cameras.firstWhere(
          (camera) => camera.lensDirection == CameraLensDirection.front,
      orElse: () => cameras.first,
    );

    final XFile? photo = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => CameraScreen(camera: frontCamera),
      ),
    );

    if (photo != null) {
      setState(() {
        imageFile = File(photo.path);
      });
      yoloOnImage();
    }
  }


  yoloOnImage() async {
    yoloResults.clear();
    Uint8List byte = await imageFile!.readAsBytes();
    final image = await decodeImageFromList(byte);
    imageHeight = image.height;
    imageWidth = image.width;
    final result = await widget.vision.yoloOnImage(
      bytesList: byte,
      imageHeight: image.height,
      imageWidth: image.width,
      iouThreshold: 0.8,
      confThreshold: 0.4,
      classThreshold: 0.5,
    );

    if (result.isNotEmpty) {
      setState(() {
        yoloResults = result;
      });

      List<String> classesDetected = yoloResults.map((result) => result['tag'].toString()).toList();

      // Verifica se Helmet e Vest estão presentes na lista
      if (classesDetected.contains('Capacete') && classesDetected.contains('Colete')) {
        updateText("Verificação concluída! Bom trabalho para você.");
        setState(() {
          showButtons = false;
        });
      } else if (classesDetected.contains('Capacete') && !classesDetected.contains('Colete')) {
        updateText("Opa, não é possivel ver o colete, tente novamente!");
      } else if (!classesDetected.contains('Capacete') && classesDetected.contains('Colete')) {
        updateText("Opa, não é possivel ver o capacete, tente novamente!");
      } else {
        updateText("Opa, não consigo ver seus EPIS, tente novamente!");
      }

      print(classesDetected);
    }
    else{
      updateText("Aguardando detecção...");
    }
  }

  void updateText(String newText) {
    setState(() {
      displayText = newText;
    });
  }

  List<Widget> displayBoxesAroundRecognizedObjects(Size screen) {
    if (yoloResults.isEmpty) return [];

    double factorX = screen.width / (imageWidth);
    double imgRatio = imageWidth / imageHeight;
    double newWidth = imageWidth * factorX;
    double newHeight = newWidth / imgRatio;
    double factorY = newHeight / (imageHeight);

    double pady = (screen.height - newHeight) / 2;

    Color colorPick = const Color.fromARGB(255, 50, 233, 30);

    List<Map<String, dynamic>> filteredResults = yoloResults
        .where((result) =>
    result['tag'] == 'Capacete' ||
        result['tag'] == 'Pessoa' ||
        result['tag'] == 'Colete')
        .toList();

    return filteredResults.map((result) {
      return Positioned(
        left: result["box"][0] * factorX,
        top: result["box"][1] * factorY + pady,
        width: (result["box"][2] - result["box"][0]) * factorX,
        height: (result["box"][3] - result["box"][1]) * factorY,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(10.0)),
            border: Border.all(color: Colors.pink, width: 2.0),
          ),
          child: Text(
            "${result['tag']} ${(result['box'][4] * 100).toStringAsFixed(0)}%",
            style: TextStyle(
              background: Paint()..color = colorPick,
              color: Colors.white,
              fontSize: 18.0,
            ),
          ),
        ),
      );
    }).toList();
  }

}



class PolygonPainter extends CustomPainter {
  final List<Map<String, double>> points;

  PolygonPainter({required this.points});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color.fromARGB(129, 255, 2, 124)
      ..strokeWidth = 2
      ..style = PaintingStyle.fill;

    final path = Path();
    if (points.isNotEmpty) {
      path.moveTo(points[0]['x']!, points[0]['y']!);
      for (var i = 1; i < points.length; i++) {
        path.lineTo(points[i]['x']!, points[i]['y']!);
      }
      path.close();
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

