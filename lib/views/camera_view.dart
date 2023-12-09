import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/controller.dart';

class CameraView extends StatelessWidget{
  const CameraView({super.key});

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: GetBuilder<Controller>(
        init: Controller(),
        builder: (controller){
          return controller.isCameraInitialize.value
              ? CameraPreview(controller.cameraController)
              : const Center(child: Text("Aguardando conexão com a câmera"),);
        },
      ),
    );
  }
}