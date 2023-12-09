import 'package:camera/camera.dart';
import 'package:flutter_tflite/flutter_tflite.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class Controller extends GetxController {

  @override
  void onInit(){
    super.onInit();
    initCamera();
  }

  @override
  void dispose(){
    super.dispose();
    cameraController.dispose();
  }

  late CameraController cameraController;
  late List<CameraDescription> cameras;

  late CameraImage cameraImage;

  var isCameraInitialize = false.obs;
  var cameraCount = 0;

  initCamera() async{
    if (await Permission.camera.request().isGranted){
      cameras = await availableCameras();
      cameraController = CameraController(
          cameras[1],
          ResolutionPreset.max);
      await cameraController.initialize().then((value) {
        cameraCount++;
        if(cameraCount %10 == 0) {
          cameraController.startImageStream((image) => objectDetector(image));
          update();
        }
      });
      isCameraInitialize(true);
      update();
    }
    else{
      print("Sem permissão");
    }
  }

  objectDetector(CameraImage image) async{
    var detector = await Tflite.runModelOnFrame(
        bytesList: image.planes.map((e) {
          return e.bytes;
        }).toList(),
      asynch: true,
      imageHeight: image.height,
      imageWidth: image.width,
      imageMean: 127.5,
      imageStd: 127.5,
      numResults: 1,
      rotation: 90,
      threshold: 0.4,
    );

    if (detector != null){
      print("Result is $detector");
    }
  }
}