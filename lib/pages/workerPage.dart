import 'package:flutter/material.dart';
import 'package:goprotect/views/camera_view.dart';

class WorkerPage extends StatelessWidget {
  final Function(String, String) onAddCard;

  const WorkerPage({Key? key, required this.onAddCard}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController functionController = TextEditingController();

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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Adicione o CameraView aqui
            Expanded(
              child: CameraView(),
            ),
            SizedBox(height: 16),
            // Container envolvendo os TextFields com BoxShadow
            Container(
              padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16), // Adiciona espaçamento interno
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 2),
                  ),
                ],
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Column(
                children: [
                  // TextField Nome
                  TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      labelText: 'Nome',
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 16,
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  // TextField Função
                  TextField(
                    controller: functionController,
                    decoration: InputDecoration(
                      labelText: 'Função',
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                String name = nameController.text;
                String function = functionController.text;

                if (name.isNotEmpty && function.isNotEmpty) {
                  onAddCard(name, function);
                  Navigator.pop(context); // Retorna à tela anterior
                } else {
                  // Trate o caso em que os campos estão vazios
                }
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 30),
              ),
              child: Text(
                'Salvar Dados',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w100,
                  fontFamily: "ProzaLibre",
                  color: Theme.of(context).scaffoldBackgroundColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
