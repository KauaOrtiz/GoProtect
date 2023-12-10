import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/controller.dart';

class CameraView extends StatelessWidget {
  const CameraView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<Controller>(
        init: Controller(),
        builder: (controller) {
          return Center(
            child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3), // Cor da sombra
                    spreadRadius: 2, // Espalhamento da sombra
                    blurRadius: 7, // Desfoque da sombra
                    offset: Offset(0, 1), // Deslocamento da sombra (x, y)
                  ),
                ],
                borderRadius: BorderRadius.circular(20.0), // Borda arredondada
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16.0), // Borda arredondada
                child: controller.isCameraInitialize.value
                    ? CameraPreview(controller.cameraController)
                    : const Center(child: Text("Aguardando conexão com a câmera")),
              ),
            ),
          );
        },
      ),
    );
  }
}
