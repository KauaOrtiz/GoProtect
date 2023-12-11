import 'package:camera/camera.dart';
import 'package:flutter_tflite/flutter_tflite.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class Controller extends GetxController {

  @override
  void onInit(){
    super.onInit();
    initCamera();
    initTLite();
  }

  @override
  void dispose() {
    super.dispose();
    cameraController.dispose();
    Tflite.close();
  }


  late CameraController cameraController;
  late List<CameraDescription> cameras;

  //late CameraImage cameraImage;

  var isCameraInitialize = false.obs;
  var cameraCount = 0;

  var x, y, w, h = 0.0;
  var label = '';

  initCamera() async{
    if (await Permission.camera.request().isGranted){
      cameras = await availableCameras();
      cameraController = CameraController(
          cameras[0],
          ResolutionPreset.max);
      await cameraController.initialize().then((value) {
          cameraController.startImageStream((image) {
            cameraCount++;
            if (cameraCount % 10 == 0){
              cameraCount = 0;
              objectDetector(image);
            }
            update();
          });
      });
      isCameraInitialize(true);
      update();
    }
    else{
      print("Sem permissão");
    }
  }

  initTLite() async{
    await Tflite.loadModel(
      model: "assets/models/modelCustom.tflite",
      labels: "assets/models/labelCustom.txt",
      isAsset: true,
      numThreads: 1,
      useGpuDelegate: false,
    );
  }

  objectDetector(CameraImage image) async {
    var detector = await Tflite.runModelOnFrame(
      bytesList: image.planes.map((e) {
        return e.bytes;
      }).toList(),
      asynch: true,
      imageHeight: image.height,
      imageWidth: image.width,
      imageMean: 127.5,
      imageStd: 127.5,
      numResults: 10, // Ajuste o número conforme necessário
      rotation: 90,
      threshold: 0.3,
    );

    if (detector != null) {
      print(detector);
      print(detector.length);
    }
  }
}