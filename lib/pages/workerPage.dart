import 'package:flutter/material.dart';

class InputScreen extends StatelessWidget {
  final Function(String, String) onAddCard;

  const InputScreen({Key? key, required this.onAddCard}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController functionController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text('Adicionar Colaborador'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Nome'),
            ),
            SizedBox(height: 16),
            TextField(
              controller: functionController,
              decoration: InputDecoration(labelText: 'Função'),
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
              child: Text('Adicionar Card'),
            ),
          ],
        ),
      ),
    );
  }
}
